require 'box_cli/auth_token_manager'
require 'box_cli/wrapper'

module BoxHelpers
  attr_reader :box_path, :local_filename
  
  def setup_filename
     @box_path = "box_cli_" + Digest::MD5.hexdigest(Time.now.strftime('%FT%T.%N%:z') + rand.to_s).tap do |path|
       # Ensure that there's nothing there
       delete_all_at_path(path)
     end
  end

  def box_wrapper
    @box_wrapper ||= BoxCli::Wrapper.new(ENV['BOX_CLI_API_KEY'], ENV['BOX_CLI_USER'], ENV['BOX_CLI_PASSWORD'])
  end

  def create_local_file
    setup_filename
    @local_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', @box_path))
    FileUtils.touch @local_filename
    @filenames ||= []
    @filenames <<  @local_filename
  end

  private

  def delete_all_at_path(path)
    # Twice, because a file and a folder can live at the same path
    delete_at_path(path)
    delete_at_path(path)
  end

  def delete_at_path(path)
    begin
      box_wrapper.delete(path)
    rescue BoxCli::NotFound
    rescue Box::Api::Unknown  # Sometimes deletion is in progress?
    end
  end
end

def box_before
  @save_env = {
    :box_cli_api_key  => ENV['BOX_CLI_API_KEY'],
    :box_cli_user     => ENV['BOX_CLI_USER'],
    :box_cli_password => ENV['BOX_CLI_PASSWORD']
  }
end

def box_after
  if @box_path
    delete_all_at_path(@box_path)
  end

  FileUtils.rm @filenames if @filenames
  
  ENV['BOX_CLI_API_KEY']  = @save_env[:box_cli_api_key]
  ENV['BOX_CLI_USER']     = @save_env[:box_cli_user]
  ENV['BOX_CLI_PASSWORD'] = @save_env[:box_cli_password]
end

World(BoxHelpers)