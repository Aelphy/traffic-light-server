# coding: utf-8

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'open-uri'
require 'ox'

require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'lib', 'traffic_light_mode')
require File.join(File.dirname(__FILE__), 'lib', 'traffic_light_branch')
set :bind, '0.0.0.0'

URL = 'http://ci.dev.apress.ru/XmlStatusReport.aspx'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join('\n')
  'Application error'
end

def authorized?
  @auth ||=  Rack::Auth::Basic::Request.new(request.env)
  @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['t','a']
end

def protected!
  unless authorized?
    response['WWW-Authenticate'] = %(Basic realm='Restricted Area')
    throw(:halt, [401, 'Oops... we need your login name & password\n'])
  end
end

get '/' do
  haml :root
end

get '/mode' do
  TrafficLightMode.get
end

get '/branch' do
  TrafficLightBranch.get
end

get '/standart' do
  protected!

  @mode = 'Стандартный'
  TrafficLightMode.set @mode
  haml :mode
end

get '/new_year' do
  protected!

  @mode = 'Новый Год'
  TrafficLightMode.set @mode
  haml :mode
end

post '/choose' do
  protected!

  @branch = params[:branch]

  @avaliable_branches = Ox.parse(open(URL).read).locate('Project').map { |node| node[:name] }

  unless @avaliable_branches.include? @branch
    return haml :branch_error
  end

  TrafficLightBranch.set @branch
  haml :branch
end
