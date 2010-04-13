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

  def test_of_delicious_feeds_response
    post '/delicious'
    
    assert last_response.ok?
    assert last_response.body.include?('<h2>')
    assert last_response.body.include?('<span>')
  end

  def test_of_delicious_feeds_parser
    @feeds = get_delicious_feeds 'http://feeds.delicious.com/v2/rss/netro?count=3'
    
    assert_equal 3, @feeds.size
    assert @feeds.first[:title].length > 0
    assert @feeds.first[:url].include?('http://')
    assert @feeds.first[:pubdate].length > 0
  end

end