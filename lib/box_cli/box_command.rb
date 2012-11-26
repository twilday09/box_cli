module BoxCli
  class BoxCommand < Command
    def initialize(options, args)
      super
      collect_globals_from_console
      partition_options
    end
    
    def wrapper
      Wrapper.new(@global_options.api_key, @global_options.user, @global_options.password)
    end
  end
end