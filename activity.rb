require 'rubygems'
require 'sinatra'
require 'erb'

get '/' do
  erb :activity
end