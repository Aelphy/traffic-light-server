require 'rubygems'
require 'daemons'
	 
pwd = Dir.pwd
Daemons.run_proc('application.rb') do
  Dir.chdir(pwd)
  exec 'ruby application.rb'
end

