require "sinatra"
require "debugger"
require_relative "../../lib/sinatra/cyclist"

class MyApp < Sinatra::Base
  register Sinatra::Cyclist

  set :views_to_cycle_through, [:page_1, :page_2]

  get "/page_1" do
    "Page 1"
  end

  get "/page_2" do
    "Page 2"
  end
end
