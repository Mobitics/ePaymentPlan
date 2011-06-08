source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'
#gem "rails", :git => "git://github.com/rails/rails.git", :branch => "3-1-stable"
gem 'rake', '= 0.8.7'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'pjax-rails'
gem 'activemerchant', :git => 'git://github.com/guilleiguaran/active_merchant.git', :branch => 'epaymentplan'
gem 'shopify_api'

#Authentication
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

group :staging do
  gem 'unicorn'
  gem 'pg'
  gem 'therubyracer-heroku'
end

group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'therubyracer-heroku'
end
