require 'spec_helper'

describe BoxCli::CreateFolderCommand do
  let(:folder_name) { 'a_very_unlikely_folder_name' }

  before(:each) do
    begin
      BoxCli::DeleteCommand.new(options, [folder_name]).call
    rescue BoxCli::NotFound
    end
  end
  
  it "creates a folder when none by that name already exists", :vcr do
    BoxCli::CreateFolderCommand.new(options, [folder_name]).call
    expect { BoxCli::InfoCommand.new(options, [folder_name]).call }.to_not raise_error
  end

  it "raises an exception when a folder by that name already exists", :vcr do
    BoxCli::CreateFolderCommand.new(options, [folder_name]).call
    expect { BoxCli::CreateFolderCommand.new(options, [folder_name]).call }.to raise_error BoxCli::FolderNameTaken
  end
end