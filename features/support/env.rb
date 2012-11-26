require 'aruba/cucumber'

Before('@requires_authorization') do
  @aruba_timeout_seconds = 10
  @aruba_io_wait_seconds = 10
end