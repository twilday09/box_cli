require 'spec_helper'

describe BoxCli::UploadCommand do
 let(:file_name) { 'a_very_unlikely_file_name.txt' }
 let(:temp_dir) { File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp')) }
 let(:local_path) { File.join(temp_dir, file_name) }

  before(:each) do
    begin
      BoxCli::DeleteCommand.new(options, [file_name]).call
    rescue BoxCli::NotFound
    end
    FileUtils.mkdir_p temp_dir
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