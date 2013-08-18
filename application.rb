#coding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')

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
  File.open(File.join(File.dirname(__FILE__), 'public', 'mode'), 'w') { |f| f << 'standart' }
  haml :mode
end

get '/new_year' do
  @mode = 'Новый Год'
  File.open(File.join(File.dirname(__FILE__), 'public', 'mode'), 'w') { |f| f << 'new_year' }
  haml :mode
end
