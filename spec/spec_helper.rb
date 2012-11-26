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