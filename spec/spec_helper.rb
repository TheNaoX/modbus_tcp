require 'rack/test'
require 'rspec'

require File.expand_path '../../lib/server.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Server end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
