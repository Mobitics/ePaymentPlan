require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'

  Resque.before_fork do |job|
    ActiveRecord::Base.establish_connection
  end
end

task "resque:scheduler" => :environment do
  require 'resque'
  require 'resque_scheduler'
  require 'resque/scheduler'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"


