module BoxHelpers
  class FakeCommanderOptions
    attr_reader :__hash__
    def initialize(options)
      @__hash__ = options
    end
    def method_missing(m, *args)
      @__hash__[m]
    end
  end

  def options
    FakeCommanderOptions.new(options_hash)
  end

  def options_with_local_option
    FakeCommanderOptions.new(options_hash.merge(options_hash_local_option))
  end
    
  def options_with_local_option_without_password
    FakeCommanderOptions.new(options_hash.merge(options_hash_local_option).reject { |k, v| k == :password })
  end
  
  def options_with_bad_credentials
    FakeCommanderOptions.new(options_hash.merge(:user => 'nonexistent_user@iorahealth.com'))
  end
  
  def options_with_bad_api_key
    FakeCommanderOptions.new(options_hash.merge(:api_key => 'mybaloneyhasafirstname'))
  end


  def options_hash
    { :user => ENV['BOX_CLI_USER'], :password => ENV['BOX_CLI_PASSWORD'], :api_key => ENV['BOX_CLI_API_KEY'] }
  end

  def options_hash_local_option
    { :local_option => 'extra' }
  end
end