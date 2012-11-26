When /^I unset all env variables matching \/([^\/]*)\/$/ do |regexp|
  ENV.keys.find_all { |k| k =~ Regexp.new(regexp) }.each { |k| ENV[k] = nil }
end

When /^I set env variable "(\w+)" to "([^"]*)"$/ do |var, value|
  ENV[var] = value
end

When /^I've set the box cli env variables$/ do
  required_env_vars = ['BOX_CLI_API_KEY', 'BOX_CLI_USER', 'BOX_CLI_PASSWORD']
  raise "\n\n* You must define the env variables #{required_env_vars.join(', ')} *\n\n\n" unless required_env_vars.all? { |v| !ENV[v].nil? }
end