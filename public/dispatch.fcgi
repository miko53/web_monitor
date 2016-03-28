#!/usr/bin/env ruby
#ENV['RAILS_ENV'] = 'development'
#ENV['HOME'] ||= `echo ~`.strip
#ENV['GEM_HOME'] = File.expand_path('~/.gems')
#ENV['GEM_PATH'] = File.expand_path('~/.gems')

#require "fcgi"

require File.dirname(__FILE__) + '/../config/environment.rb'

class Rack::PathInfoRewriter
  def initialize(app)
    @app = app
  end
  def call(env)
    env.delete('SCRIPT_NAME')
    parts = env['REQUEST_URI'].split('?')
    env['PATH_INFO'] = parts[0]
    env['QUERY_STRING'] = parts[1].to_s
    @app.call(env)
  end
end

Rack::Handler::FastCGI.run  Rack::PathInfoRewriter.new(SensorsMon::Application)

