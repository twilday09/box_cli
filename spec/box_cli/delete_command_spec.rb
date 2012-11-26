require 'spec_helper'

describe BoxCli::DeleteCommand do
  let(:folder_name) { 'a_very_unlikely_folder_name' }

  before(:each) do
    begin
      BoxCli::DeleteCommand.new(options, [folder_name]).call
    rescue BoxCli::NotFound
    end
  end
  
  it "raises an exception when there is nothing to delete", :vcr do
    expect { BoxCli::DeleteCommand.new(options, [folder_name]).call }.to raise_error BoxCli::NotFound
  end

  it "does not raise an exception when deleting something that exists", :vcr do
    BoxCli::CreateFolderCommand.new(options, [folder_name]).call
    expect { BoxCli::DeleteCommand.new(options, [folder_name]).call }.to_not raise_error
  end

  it "deletes the item when something is there", :vcr do
    BoxCli::CreateFolderCommand.new(options, [folder_name]).call
    BoxCli::DeleteCommand.new(options, [folder_name]).call
    expect { BoxCli::InfoCommand.new(options, [folder_name]).call }.to raise_error BoxCli::NotFound
  end
end