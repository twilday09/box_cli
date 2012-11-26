require 'box_cli/version'
require 'box_cli/auth_token_manager'
require 'box_cli/hash_to_pretty'
require 'box_cli/displayer'
require 'box_cli/wrapper'

require 'box_cli/command'
require 'box_cli/box_command'
require 'box_cli/account_info_command'
require 'box_cli/create_folder_command'
require 'box_cli/delete_command'
require 'box_cli/info_command'
require 'box_cli/settings_command'
require 'box_cli/terminal'
require 'box_cli/upload_command'

require 'active_support/inflector'

module BoxCli
  def self.dispatch(name, options, args)
    "BoxCli::#{name.camelize}Command".constantize.new(options, args).call
    0
  rescue Exception => e
    puts "#{e.message}"
    1
  end
end