require "sinatra"
require "debugger"
require_relative "../../lib/sinatra/cyclist"

set :views, [:page_1, :page_2]

get "/page_1" do
  "Page 1"
end

get "/page_2" do
  "Page 2"
end
