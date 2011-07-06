source 'http://rubygems.org'

# Stack
gem 'rails', '>= 3.1.0.rc4'
gem 'sass-rails', '>= 3.1.0.rc.2'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'rack-www-enforcer'


# Site base
gem 'activemerchant'
gem 'shopify_api'
gem 'resque'
gem 'resque-scheduler'
gem "meta_search",  '>= 1.1.0.pre'
gem 'devise', '>= 1.3.0'
gem "meta_search", '>= 1.1.0.pre'
gem 'activeadmin', :git => 'git://github.com/gregbell/active_admin.git', :branch => 'rails-3-1'


group :development, :test do
  gem 'therubyracer', '0.9.1'
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rspec-rails', '2.6.1.beta1'
  gem 'autotest'
  gem 'factory_girl_rails'
  gem 'factory_girl'
  gem 'fakeredis'
end

group :production, :staging do
  gem 'unicorn'
  gem 'pg'
  gem 'therubyracer-heroku'
end
