require 'rubygems'
require 'bundler/setup'
require 'vcr'
require 'box_helpers'
require 'mocha_standalone'
require 'bourne'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH << File.join(PROJECT_ROOT, "lib")
require 'box_cli'

class String
  # From ActiveSupport
  def strip_heredoc
    indent = chomp.scan(/^\s*/).min.size
    gsub(/^\s{#{indent}}/, '')
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/cassettes'
  c.hook_into :fakeweb
  c.default_cassette_options = { :serialize_with => :json }
  c.preserve_exact_body_bytes do |http_message|
    RUBY_VERSION == '1.8.7' || (http_message.body.encoding.name == 'ASCII-8BIT' || !http_message.body.valid_encoding?)
  end
  c.filter_sensitive_data("<BOX_CLI_USER>")     { ENV['BOX_CLI_USER'] }
  c.filter_sensitive_data("<BOX_CLI_PASSWORD>") { ENV['BOX_CLI_PASSWORD'] }
  c.filter_sensitive_data("<BOX_CLI_API_KEY>")  { ENV['BOX_CLI_API_KEY'] }
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.mock_with :mocha
  config.order = :random
  config.include BoxHelpers
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.treat_symbols_as_metadata_keys_with_true_values = true
end