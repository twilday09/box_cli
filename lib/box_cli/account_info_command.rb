module BoxCli
  class AccountInfoCommand < BoxCommand
    def call
      Displayer.new.display wrapper.account_info.extend(HashToPretty).to_pretty
    end
  end
end