source 'http://rubygems.org'

# Stack
gem 'rails', :git => 'git@github.com:guilleiguaran/rails.git', :branch => 'scss-compressor'
gem 'sass-rails', '>= 3.1.0.rc.2'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'


# Payments
gem 'activemerchant', :git => 'git://github.com/guilleiguaran/active_merchant.git', :branch => 'epaymentplan'
gem 'shopify_api'
gem 'resque'
gem 'resque-scheduler'

# Authentication
gem 'devise', '>= 1.3.0'


group :development, :test do
  gem 'therubyracer'
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rspec-rails', '2.6.1.beta1'
  gem 'autotest'
  gem 'rcov'
  gem 'factory_girl_rails'
  gem 'factory_girl'
end

group :production, :staging do
  gem 'unicorn'
  gem 'pg'
  gem 'therubyracer-heroku'
end
