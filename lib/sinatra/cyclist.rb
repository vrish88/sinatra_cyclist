require 'sinatra/base'
require_relative 'cyclist/version'

module Sinatra
  module Cyclist
    def self.registered(app)
      app.enable :sessions
      app.set :routes_to_cycle_through, []
      app.set :routes_to_cycle_through_group, {}
      app.set :cycle_duration, 3

      app.get '/_cycle' do
        cycle_through_pages = settings.routes_to_cycle_through
        if params[:group]
          group = params[:group]
          cycle_through_pages = settings.routes_to_cycle_through_group[group]
        end

        if session[:_cycle_group]
          group = session[:_cycle_group]
          cycle_through_pages = settings.routes_to_cycle_through_group[group]
        end

        return if cycle_through_pages.empty?

        page_index = session[:_cycle_page_index] || -1
        session[:_cycle_page_index] = page_index + 1

        number_of_routes = cycle_through_pages.length
        page = cycle_through_pages[session[:_cycle_page_index] % number_of_routes]

        session[:_cycle_duration] = params[:duration] if params[:duration]
        session[:_cycle_duration] ||= settings.cycle_duration
        session[:_cycle_group] = params[:group] if params[:group]

        session[:_cycle] = true

        redirect "/#{page}"
      end

      app.before do
        if session[:_cycle]
          headers['Refresh'] = "#{session[:_cycle_duration]}; url=/_cycle"
          session[:_cycle] = false
        end
      end
    end
  end

  register Cyclist
end
