module BoxCli
  class Terminal
    def self.ask(prompt)
      highline.ask(prompt)
    end
    
    private
    
    def self.highline
      @highline ||= HighLine.new
    end
  end
end