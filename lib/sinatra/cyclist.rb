require "sinatra/base"
require_relative "cyclist/version"

module Sinatra
  module Cyclist
    def self.registered(app)
      app.enable :sessions

      app.get "/_cycle" do
        page_index = session[:_cycle_page_index] || -1
        session[:_cycle_page_index] = page_index + 1

        number_of_views = settings.views_to_cycle_through.length
        page = settings.views_to_cycle_through[session[:_cycle_page_index] % number_of_views]

        session[:_cycle_duration] ||= params[:duration] || 3

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
