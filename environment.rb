#coding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'haml'
require 'ostruct'

require 'sinatra' unless defined?(Sinatra)

configure do
  SiteConfig = OpenStruct.new(
                 title: 'Билд Светофор АбакПресс',
                 author: 'Aelphy')

  # load models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }
end
