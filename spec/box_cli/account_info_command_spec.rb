require 'spec_helper'

describe BoxCli::AccountInfoCommand do
  it "returns account info for good credentials and an api key", :vcr do
    BoxCli::Displayer.any_instance.expects(:display).with(regexp_matches(/Status\:\s+get_account_info_ok\s+User:\s+Access:\s+\d+\s+Email:\s+/))
    BoxCli::AccountInfoCommand.new(options, []).call
  end
end