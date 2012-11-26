module BoxCli
  class SettingsCommand < Command
    def initialize(options, args)
      super
      collect_globals_from_env
    end

    def call
      STDOUT.puts("Options:\n".tap do |s|
        if @options.__hash__.empty?
          s << "  (none)\n"
        else
          s << @options.__hash__.keys.map(&:to_s).sort.map { |k| "  %s: %s" % [k, @options.__hash__[k.to_sym]] }.join("\n")
        end
        s << "\n\nArguments:\n"
        if @args.empty?
          s << "  (none)\n"
        else
          s << @args.map { |p| "  #{p}" }.join("\n")
        end
      end)
    end
  end
end