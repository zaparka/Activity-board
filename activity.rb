require 'rubygems'
require 'sinatra'
require 'erb'
require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'feed_tools'

require 'parsers/delicious'
require 'parsers/twitter'
require 'parsers/github'


configure do
  @@settings = YAML::load(File.read('settings.yml'))
  enable :sessions
  set :sessions, true
end

get '/' do
  erb :activity
end

post '/delicious' do
  @feeds = delicious_feeds @@settings['delicious']
  erb :delicious
end

post '/twitter' do
  @messages = twitter_messages @@settings['twitter'], @@settings['twitter_messagges_count']
  erb :twitter
end

post '/github' do 
  @commits = github @@settings['github_user_name'], @@settings['github_token']
  erb :github
end

get '/js/jquery.js' do
  headers 'Content-Type' => 'text/javascript; charset=utf-8'
  File.read( File.join( File.dirname( __FILE__ ), 'js', 'jquery.js' ) )
end

get '/js/activity.js' do
  headers 'Content-Type' => 'text/javascript; charset=utf-8'
  File.read( File.join( File.dirname( __FILE__ ), 'js', 'activity.js' ) )
end

get '/css/activity.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  File.read(File.join(File.dirname(__FILE__), 'css', 'activity.css' ) )
end