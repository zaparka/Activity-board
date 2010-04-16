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
    assert last_response.body.include?('<h3>')
    assert last_response.body.include?('http://')
    assert last_response.body.include?('<span>')
  end

  def test_of_delicious_feeds_parser
    feeds = delicious_feeds @@settings['delicious']

    assert_equal 3, feeds.size
    assert feeds.first[:title].length > 0
    assert feeds.first[:url].include?('http://')
    assert feeds.first[:published].length > 0
  end

  def test_of_twitter_messages_parser
    messages = twitter_messages @@settings['twitter'], 4

    assert_equal 3, messages.size
    assert messages.first[:title].length > 0
    assert messages.first[:text].length > 0
    assert messages.first[:published].length > 0
  end

  def test_of_delicious_feeds_response
    post '/twitter'

    assert last_response.ok?
    assert last_response.body.include?('<h3>')
    assert last_response.body.include?('<p>')
    assert last_response.body.include?('<span>')
  end

  def test_of_githab_parser
    commits = github @@settings['github_user_name'], @@settings['github_token']

    assert_equal 3, commits.size
    assert commits.first[:title].length > 0
    assert commits.first[:description].length > 0
    assert commits.first[:published].length > 0
  end

  def test_of_github_feeds_response
    post '/github'

    assert last_response.ok?
    assert last_response.body.include?('<h3>')
    assert last_response.body.include?('<p>')
    assert last_response.body.include?('<span>')
  end

  def test_of_expired_method_at_cash
    cash = Cache.new

    assert_equal true, cash.expired?('ticket')
  end

  def test_of_write_method_at_cash
    cash = Cache.new
    cash.write('ticket','Tickets for Movie')

    assert_equal false, cash.expired?('ticket')
  end

  def test_of_write_and_read_method_at_cash
    cash = Cache.new
    cash.write('ticket','Tickets for Movie')

    assert_equal false, cash.expired?('ticket')
    assert_equal 'Tickets for Movie', cash.read('ticket')
  end

end