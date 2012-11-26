require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

desc 'Default: run specs and features'
task :default => [:spec, :cucumber]

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color', '--format progress']
  t.pattern = 'spec/box_cli/**/*_spec.rb'
end

desc 'Run cucumber features'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = [
    '--tags', '~@wip',
    '--tags', '~@requires_authorization',
    '--format', (ENV['CUCUMBER_FORMAT'] || 'progress')
  ]
end