require 'spec_helper'

describe BoxCli::SettingsCommand do
  it "provides output regarding options" do
    STDOUT.expects(:puts).with(regexp_matches(/Options:\s+api_key:\s+\w+\s+password:\s+\w+\s+user:\s+\w+/m))
    BoxCli::SettingsCommand.new(options, []).call
  end
  it "provides output regarding arguments" do
    STDOUT.expects(:puts).with(regexp_matches(/Arguments:\s+arg2\s+arg1/m))
    BoxCli::SettingsCommand.new(options, ['arg2', 'arg1']).call
  end
end