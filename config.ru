require File.join(File.dirname(__FILE__), 'application')

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Rack::URLMap.new({
  '/' => Public,
  '/standart' => Protected,
  '/new_year' => Protected,
  '/choose' => Protected,
  '/mode' => Public,
  '/branch' => Public
})

