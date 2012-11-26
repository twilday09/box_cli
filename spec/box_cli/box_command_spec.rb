require 'spec_helper'
require 'ostruct'

describe BoxCli::BoxCommand, '.new', 'options' do
  subject(:command) { BoxCli::BoxCommand.new(options_with_local_option, ['arg2', 'arg1']) }
  it "partitions :user, :password, and :api_key into the global options" do
    expect(command.global_options).to eq OpenStruct.new(options_hash)
  end
  it "partitions :some_local_option into the local options" do
    expect(command.local_options).to eq OpenStruct.new(options_hash_local_option)
  end
  it "initializes the args" do
    expect(command.args).to eq ['arg2', 'arg1']
  end
end

describe BoxCli::BoxCommand, '.new', 'prompting' do
  before do
    @save_password = ENV['BOX_CLI_PASSWORD']
    ENV['BOX_CLI_PASSWORD'] = nil
    BoxCli::Terminal.stubs(:ask)
    BoxCli::BoxCommand.new(options_with_local_option_without_password, ['arg2', 'arg1'])
  end
  after do
    ENV['BOX_CLI_PASSWORD'] = @save_password
  end
  it "prompts for missing global options" do
    expect(BoxCli::Terminal).to have_received(:ask).with('password: ')
  end
end

describe BoxCli::BoxCommand, '#wrapper' do
  subject(:command) { BoxCli::BoxCommand.new(options_with_local_option, ['arg2', 'arg1']) }
  before do
    BoxCli::Wrapper.stubs(:new)
    command.wrapper
  end
  it "creates an instance of BoxCli::Wrapper with the user, password, and api_key" do
    expect(BoxCli::Wrapper).to have_received(:new).with(options_hash[:api_key], options_hash[:user], options_hash[:password])
  end
end

describe BoxCli::BoxCommand, '#wrapper' do
  subject(:command) { BoxCli::BoxCommand.new(options_with_local_option, ['arg2', 'arg1']) }
  before do
    command.wrapper
  end
  it "returns a kind of a BoxCli::Wrapper" do
    expect(command.wrapper).to be_a_kind_of(BoxCli::Wrapper)
  end
end