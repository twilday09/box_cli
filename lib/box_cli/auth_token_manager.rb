module BoxCli
  class AuthTokenManager
    DEFAULT_RC = "~/.box_cli_rc"

    def initialize(username)
      @username = username
      @auth_tokens = {}
      if File.exists?(rc_path)
        begin
          @auth_tokens = YAML.load_file(rc_path)
        rescue StandardError => e
          STDERR.puts "Couldn't load auth tokens from '#{rc_path}': #{e.message}"
        end
      else
        remove
      end
    end

    def get_auth_token
      @auth_tokens[@username]
    end

    def remove
      save(nil)
    end

    def save(auth_token)
      @auth_tokens[@username] = auth_token
      File.open(rc_path, 'w') { |f| YAML.dump(@auth_tokens, f) }
    rescue StandardError => e
      STDERR.puts "Couldn't save auth tokens to '#{rc_path}': #{e.message}"
    end

    private
    
    def rc_path
      @rc_path ||= File.expand_path(DEFAULT_RC)
    end
  end
end