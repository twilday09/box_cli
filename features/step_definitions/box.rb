require 'box_cli/wrapper'

When /^I create a temporary folder at box$/ do
  setup_filename
  box_wrapper.create_folder(box_path)
end

When /^I create a local temporary file$/ do
  create_local_file
end

When /^I create a temporary file at box$/ do
  create_local_file
  box_wrapper.upload(local_filename, '/')
end

Then /^there should be something at the temporary path$/ do
  box_wrapper.info(box_path)
end

Then /^there should be nothing at the temporary path$/ do
  begin
    box_wrapper.info(box_path)
    raise "Expected nothing at '#{box_path}'"
  rescue BoxCli::NotFound
  end
end

When /^I run `box delete` on the temporary path$/ do
  step "I run `box delete #{box_path}`"
end

When /^I run `box info` on the temporary path$/ do
  step "I run `box info #{box_path}`"
end

When /^I run `box upload` for a local temporary file$/ do
  step "I run `box upload #{local_filename} /`"
end

When /^I create a folder named "(.*?)"$/ do |folder_name|
  step "I run `box create_folder #{folder_name}`"
end