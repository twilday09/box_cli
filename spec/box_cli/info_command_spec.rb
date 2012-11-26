require 'spec_helper'

describe BoxCli::InfoCommand do
  let(:folder_name) { 'a_very_unlikely_folder_name' }

  before(:each) do
    begin
      BoxCli::DeleteCommand.new(options, [folder_name]).call
    rescue BoxCli::NotFound
    end
  end
  
  it "provides output regarding the item if it exists", :vcr do
    BoxCli::CreateFolderCommand.new(options, [folder_name]).call
    BoxCli::Displayer.any_instance.expects(:display).with(regexp_matches(/Type:\s+folder\s+Data:\s+.*?Name:\s+#{Regexp.escape(folder_name)}/m))
    BoxCli::InfoCommand.new(options, [folder_name]).call
  end

  it "raises an exception if nothing is there", :vcr do
    expect { BoxCli::InfoCommand.new(options, [folder_name]).call }.to raise_error BoxCli::NotFound
  end
end