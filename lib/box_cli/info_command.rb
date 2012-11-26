module BoxCli
  class InfoCommand < BoxCommand
    def call
      path, = @args
      path ||= '.'
      info = wrapper.info(path)
      Displayer.new.display info.extend(HashToPretty).to_pretty
    end
  end
end