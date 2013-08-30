#coding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'lib', 'traffic_light_mode')

set :bind, '0.0.0.0'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

get '/' do
  haml :root
end

get '/standart' do
  @mode = 'Стандартный'
  TrafficLightMode.set 'Стандартный'
  haml :mode
end

get '/new_year' do
  @mode = 'Новый Год'
  TrafficLightMode.set 'Новый Год'
  haml :mode
end

get '/mode' do
  TrafficLightMode.get
end
