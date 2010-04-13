require 'activity'
require 'test/unit'
require 'rack/test'

set :environment, :test

class ActivityTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
  end

end