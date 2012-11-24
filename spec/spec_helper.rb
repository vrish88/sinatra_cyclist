require "rspec"
require "sinatra"
require "sinatra/cyclist"

Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment
