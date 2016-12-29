require 'rubygems'
require 'bundler'
require 'securerandom'

RACK_ENV = ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, RACK_ENV)
require "sinatra/reloader" if RACK_ENV == 'development'

require_rel 'database.rb'
require_all 'lib'
require_all 'models'
require_all 'helpers'
require_rel 'cors.rb'
require_all 'apis'
