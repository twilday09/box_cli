$LOAD_PATH.unshift File.expand_path(File.join('..', 'lib'), __FILE__)
require 'box_cli/version'

Gem::Specification.new do |s|
  s.name          = 'box_cli'
  s.version       = BoxCli::VERSION
  s.date          = Time.now.utc.strftime('%Y-%m-%d')
  s.summary       = 'CLI for box'
  s.description   = 'CLI for box'
  s.authors       = ['Iora Health']
  s.email         = 'rubygems@iorahealth.com'
  s.files         = `git ls-files`.split("\n")
  s.homepage      = 'https://github.com/IoraHealth/box_cli'
  s.rdoc_options  = ['--charset=UTF-8']
  s.require_paths = ['lib']
  s.test_files    = `git ls-files spec`.split("\n")
  s.add_dependency 'box-api'
  s.add_dependency 'active_support'
  s.add_dependency 'commander'
  s.add_dependency 'highline',             '~> 1.6.15'
  s.add_dependency 'mechanize'
  s.executables << 'box'

  s.add_development_dependency 'aruba',    '~> 0.4.11'
  s.add_development_dependency 'bourne',   '~> 1.2.0'
  s.add_development_dependency 'cucumber', '~> 1.2.1'
  s.add_development_dependency 'fakeweb',  '~> 1.3.0'
  s.add_development_dependency 'mocha',    '~> 0.12.3'
  s.add_development_dependency 'rake',     '~> 0.9.2'
  s.add_development_dependency 'rspec',    '~> 2.11.0'
  s.add_development_dependency 'vcr',      '~> 2.2.5'
end