require 'rubygems'
require 'bundler'
require 'moneta'

Bundler.require

require './app.rb'
run Sinatra::Application