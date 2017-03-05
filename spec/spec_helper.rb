require 'rack/test'
require 'rspec'

# Require the server file
require File.expand_path '../../lib/server.rb', __FILE__

# Include this rack/test module for using with RSpec
module AppHelper
  include Rack::Test::Methods
  def app() Server end
end

# Include the helper module in rspec
RSpec.configure do |c|
  c.include AppHelper
end
