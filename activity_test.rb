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

  def test_of_index_page
    get '/'

    assert last_response.ok?
    assert last_response.body.include?('Board of my recent activities')
  end

  def test_of_js_library_load
    get '/js/jquery.js'

    assert last_response.ok?
    assert last_response.body.include?('jQuery JavaScript Library v1.4.2')
  end

  def test_of_js_activity_file_load
    get '/js/activity.js'

    assert last_response.ok?
    assert last_response.body.include?('JavaScript Document for Activity board')
  end
  
  def test_of_css_activity_file_load
    get '/css/activity.css'

    assert last_response.ok?
    assert last_response.body.include?('CSS Document for Activity board')
  end

  def test_of_delicious_feeds_response
    post '/delicious'
    
    assert last_response.ok?
    assert last_response.body.include?('<h2>')
    assert last_response.body.include?('<span>')
  end

  def test_of_delicious_feeds_parser
    @feeds = get_delicious_feeds @@settings['delicious']
    
    assert_equal 3, @feeds.size
    assert @feeds.first[:title].length > 0
    assert @feeds.first[:url].include?('http://')
    assert @feeds.first[:pubdate].length > 0
  end

end