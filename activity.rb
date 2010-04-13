require 'rubygems'
require 'sinatra'
require 'erb'
require 'parsers/delicious'

get '/' do
  erb :activity
end

post '/delicious' do
  @feeds = get_delicious_feeds 'http://feeds.delicious.com/v2/rss/netro?count=3'
  erb :delicious
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