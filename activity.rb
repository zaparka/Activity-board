require 'rubygems'
require 'sinatra'
require 'erb'
require 'parsers/delicious'
require 'yaml'

configure do
  @@settings = YAML::load(File.read('settings.yml'))
end

get '/' do
  erb :activity
end

post '/delicious' do
  @feeds = get_delicious_feeds @@settings['delicious']
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