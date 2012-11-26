require 'spec_helper'

describe 'Generic Box Command' do
  it "fails for bad credentials", :vcr do
    expect { BoxCli::AccountInfoCommand.new(options_with_bad_credentials, []).call }.to raise_error BoxCli::NotAuthorized
  end
  it "fails for a bad api key", :vcr do
    expect { BoxCli::AccountInfoCommand.new(options_with_bad_api_key, []).call }.to raise_error Box::Api::Restricted
  end
end