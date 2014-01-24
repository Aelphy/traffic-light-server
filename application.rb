#coding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'open-uri'
require 'ox'

require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'lib', 'traffic_light_mode')
require File.join(File.dirname(__FILE__), 'lib', 'traffic_light_branch')

set :bind, '0.0.0.0'

use Rack::Auth::Basic, 'Restricted Area' do |username, password|
  username == 'traffic-light-administrator' and password == 'traffic-light'
end

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

URL = 'http://ci.dev.apress.ru/XmlStatusReport.aspx'

get '/' do
  haml :root
end

get '/standart' do
  @mode = 'Стандартный'
  TrafficLightMode.set @mode
  haml :mode
end

get '/new_year' do
  @mode = 'Новый Год'
  TrafficLightMode.set @mode
  haml :mode
end

get '/mode' do
  TrafficLightMode.get
end

get '/branch' do
  TrafficLightBranch.get
end

post '/choose' do
  @branch = params[:branch]

  @avaliable_branches = Ox.parse(open(URL).read).locate('Project').map { |node| node[:name] }

  unless @avaliable_branches.include? @branch
    return haml :branch_error
  end

  TrafficLightBranch.set @branch
  haml :branch
end
