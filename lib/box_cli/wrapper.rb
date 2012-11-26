require 'box-api'
require 'mechanize'
require 'active_support/ordered_hash'
require 'active_support/hash_with_indifferent_access'

module Box
  class Account
    send(:public, :api)
  end

  class Api
    def auth_token
      @auth_token
    end
    
    query_string_normalizer proc { |query|
      indifferent = ActiveSupport::HashWithIndifferentAccess.new(query)
      query.keys.map(&:to_s).sort.map do |key|
        value = indifferent[key]
        if value.nil?
          key
        elsif Array === value
          value.map { |v| "#{key}[]=#{URI.encode(v.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}" }
        else
          "#{key}=#{value}"
        end
      end.flatten.join('&')
    }
  end
end

module BoxCli
  class Exception < ::Exception; end
  class NotFound < Exception; end
  class NotAuthorized < Exception; end
  class FolderNameTaken < Exception; end
  class FileNameTaken < Exception; end
  
  class Wrapper
    def initialize(api_key, username, password)
      @api_key, @username, @password = api_key, username, password
    end

    def self.auth_token_manager_class=(auth_token_manager_class)
      @auth_token_manager_class = auth_token_manager_class
    end
    
    def self.auth_token_manager_class
      @auth_token_manager_class || AuthTokenManager
    end
    
    def auth_token_manager=(auth_token_manager)
      @auth_token_manager = auth_token_manager
    end
    
    def auth_token_manager
      @auth_token_manager || self.class.auth_token_manager_class.new(@username)
    end
    
    def account_info
      api.get_account_info
    end
    
    def create_folder(folder_name)
      folder = root.create(folder_name)
      folder.id
    rescue Box::Api::NameTaken => e
      raise FolderNameTaken.new("Folder '#{folder_name}' already exists")
    end

    def delete(remote_path)
      item = root.at(remote_path)
      raise NotFound.new("Nothing found at '#{remote_path}'") unless item
      api.delete(item.type, item.id)
    end
    
    def info(remote_path)
      item = root.at(remote_path)
      raise NotFound.new("Nothing found at '#{remote_path}'") unless item
      ActiveSupport::OrderedHash[:type, item.type, :data, item.data]
    end

    def upload(local_path, remote_path)
      target_folder = root.at(remote_path)
      basename = File.basename(local_path)
      target_path = File.join(remote_path, basename)
      if item = root.at(target_path)
        raise FileNameTaken.new("File '#{basename}' already exists at #{remote_path}")
      else
        api.upload(local_path, target_folder.id)
      end
    end
    
    def upload_or_overwrite(local_path, remote_path)
      target_folder = root.at(remote_path)
      target_path = File.join(remote_path, File.basename(local_path))
      if item = root.at(target_path)
        api.overwrite(local_path, item.id)
      else
        api.upload(local_path, target_folder.id)
      end
    end

    def root_folder_id
      root.id
    end

    private

    def api
      account.api
    end
    
    def account
      unless @account
        @api = Box::Api.new(@api_key)
        account = Box::Account.new(@api)
        auth_token = auth_token_manager.get_auth_token
        account.authorize(:auth_token => auth_token) do |auth_url|
          authorize(auth_url, @username, @password)
        end
        unless account.authorized?
          auth_token_manager.remove
          raise NotAuthorized
        end
        auth_token_manager.save(auth_token)
        @account = account
      end
      @account
    end

    def authorize(auth_url, username, password)
      Mechanize.new do |agent|
        agent.user_agent = :safari
        agent.get(auth_url) do |login_page|
          login_page.form_with(:name => 'login_form1') do |login_form|
            login_form['login'] = username
            login_form['password'] = password
            return login_form.submit
          end
        end
      end
    end
    
    def root
      account.root
    end
  end
end