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
require 'cache'

configure do
  @@settings = YAML::load(File.read('settings.yml'))
  @@cache = Cache.new
end

get '/' do
  erb :activity
end

post '/delicious' do
  if @@cache.expired? 'delicious' or params['reload']
    @feeds = delicious_feeds @@settings['delicious']
    @@cache.write('delicious', erb(:delicious) )
  end

  @@cache.read('delicious') + "<span>#{params['reload']}</span>"
end

post '/twitter' do
  if @@cache.expired? 'twitter' or params['reload']
    @messages = twitter_messages @@settings['twitter'], @@settings['twitter_messagges_count']
    @@cache.write('twitter', erb(:twitter) )
  end

  @@cache.read('twitter')
end

post '/github' do
  if @@cache.expired? 'github' or params['reload']
    @commits = github @@settings['github_user_name'], @@settings['github_token']
    @@cache.write('github', erb(:github) )
  end

  @@cache.read('github')
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

get '/img/loader.gif' do
  headers 'Content-Type' => 'image/jpeg;'
  File.read(File.join(File.dirname(__FILE__), 'img', 'loader.gif' ) )
end