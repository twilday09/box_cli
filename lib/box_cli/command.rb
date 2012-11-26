require 'ostruct'
require 'highline'

module BoxCli
  class Command
    attr_reader :global_options, :local_options, :args

    GLOBAL_OPTION_NAMES = [:user, :password, :api_key]
    
    def initialize(options, args)
      @options, @args = options, args
    end

    private
    
    def collect_globals_from_env
      GLOBAL_OPTION_NAMES.each do |option_name|
        @options.__hash__[option_name] ||= ENV["BOX_CLI_#{option_name.to_s.upcase}"]
      end
    end
    
    def collect_globals_from_console
      collect_globals_from_env
      @options.api_key  = Terminal.ask('api_key: ')                       unless @options.api_key
      @options.user     = Terminal.ask('user: ')                          unless @options.user
      @options.password = Terminal.ask('password: ') { |q| q.echo = '*' } unless @options.password
    end

    def partition_options
      @global_options, @local_options = @options.__hash__.partition { |(k,v)|  GLOBAL_OPTION_NAMES.include?(k) }.map { |a| OpenStruct.new(Hash[a]) }
    end
  end
end