require 'spec_helper'

describe BoxCli::HashToPretty do
  it "generates a pretty string for a hash" do
    expect({ :a => 1, :b => 2 }.extend(BoxCli::HashToPretty).to_pretty).to eq(<<-PRETTY.strip_heredoc)
    A: 1
    B: 2
    PRETTY
  end
  it "can handle keys that are strings or symbols" do
    expect({ :a => 1, 'b' => 2 }.extend(BoxCli::HashToPretty).to_pretty).to eq(<<-PRETTY.strip_heredoc)
    A: 1
    B: 2
    PRETTY
  end
  it "Preserves top-level key order when an ordered hash is used" do
    expect(ActiveSupport::OrderedHash[:b, 2, :a, 1 ].extend(BoxCli::HashToPretty).to_pretty).to eq(<<-PRETTY.strip_heredoc)
    B: 2
    A: 1
    PRETTY
  end
  it "lines up the key/value pairs when the keys have different length" do
    expect({ :a => 1, :beta => 2 }.extend(BoxCli::HashToPretty).to_pretty).to eq(<<-PRETTY.strip_heredoc)
    A:    1
    Beta: 2
    PRETTY
  end
  it "Humanizes the keys" do
    expect({ :social_security_number => '457-55-5462', :title => 'LifeLock CEO' }.extend(BoxCli::HashToPretty).to_pretty).to eq(<<-PRETTY.strip_heredoc)
    Social security number: 457-55-5462
    Title:                  LifeLock CEO
    PRETTY
  end
  it "Indents values that are themselves hashes" do
    expect({ :a => 1, :b => { :x => 2, :y => 3, :z => 4}, :c => 5 }.extend(BoxCli::HashToPretty).to_pretty).to eq(<<-PRETTY.strip_heredoc)
    A: 1
    B:
       X: 2
       Y: 3
       Z: 4
    C: 5
    PRETTY
  end
  it "Provides a means to display hierarchical hash data that don't look like garbage" do
    expect({ "status" => "get_account_info_ok", "user" => { "login" => "john@iorahealth.com", "email" => "john@iorahealth.com", "access_id" => "11756654", "user_id" => "11756654", "space_amount" => "21474836480", "space_used" => "1657381031", "max_upload_size" => "2147483647" } }.extend(BoxCli::HashToPretty).to_pretty).to eq(<<-PRETTY.strip_heredoc)
    Status: get_account_info_ok
    User:
       Access:          11756654
       Email:           john@iorahealth.com
       Login:           john@iorahealth.com
       Max upload size: 2147483647
       Space amount:    21474836480
       Space used:      1657381031
       User:            11756654
    PRETTY
  end
end