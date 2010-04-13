require 'rubygems'
require 'sinatra'
require 'erb'
require 'parsers/delicious'

get '/' do
  erb :activity
end

post '/delicious' do
  @feeds = get_delicious_feeds 'http://feeds.delicious.com/v2/rss/netro?count=15'
  erb :delicious
end