module BoxCli
  class Displayer
    def initialize(f = STDOUT)
      @f = f
    end
    def display(s)
      STDOUT.puts s
    end
  end
end