require_relative 'boot.rb'

set :token_secret, SecureRandom.base64(64)

run Sinatra::Application
