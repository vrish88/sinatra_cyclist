require "sinatra/base"
require_relative "cyclist/version"

module Sinatra
  module Cyclist
    def self.registered(app)
      app.enable :sessions
      app.set :routes_to_cycle_through, []

      app.get "/_cycle" do
        return if settings.routes_to_cycle_through.empty?

        page_index = session[:_cycle_page_index] || -1
        session[:_cycle_page_index] = page_index + 1

        number_of_routes = settings.routes_to_cycle_through.length
        page = settings.routes_to_cycle_through[session[:_cycle_page_index] % number_of_routes]

        session[:_cycle_duration] = params[:duration] || 3

        session[:_cycle] = true

        redirect "/#{page}"
      end

      app.before do
        if session[:_cycle]
          headers["Refresh"] = "#{session[:_cycle_duration]}; url=/_cycle"
          session[:_cycle] = false
        end
      end
    end
  end

  register Cyclist
end
