require 'resque/failure/multiple'
require 'resque/failure/hoptoad'
require 'resque/failure/redis'
require 'resque/server'

Resque::Server.use Rack::Auth::Basic do |username, password|
  password == "epaymentplans"
end

if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  Resque.redis = Redis.new
end


# Failure notifications
#Resque::Failure::Hoptoad.configure do |config|
#  config.api_key = config.api_key = ENV['HOPTOAD_API_KEY']
#  config.secure = true
#end
#Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Hoptoad]
#Resque::Failure.backend = Resque::Failure::Multiple
