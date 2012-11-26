require 'spec_helper'

describe BoxCli::UploadCommand do
 let(:file_name) { 'a_very_unlikely_file_name.txt' }
 let(:local_path) { File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', file_name)) }

  before(:each) do
    begin
      BoxCli::DeleteCommand.new(options, [file_name]).call
    rescue BoxCli::NotFound
    end
    FileUtils.touch local_path
  end
  
  after(:each) do
    FileUtils.rm local_path
  end
  
  it "uploads a file when none by that name already exists", :vcr do
    BoxCli::UploadCommand.new(options, [local_path, '/']).call
    expect { BoxCli::InfoCommand.new(options, [file_name]).call }.to_not raise_error
  end

  it "raises an exception when a file by that name already exists", :vcr do
    BoxCli::UploadCommand.new(options, [local_path, '/']).call
    expect {  BoxCli::UploadCommand.new(options, [local_path, '/']).call }.to raise_error BoxCli::FileNameTaken
  end
end