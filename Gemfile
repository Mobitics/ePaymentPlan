source 'http://rubygems.org'

gem 'rails', :git => "https://github.com/rails/rails.git"
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'pjax-rails'
gem 'activemerchant', :git => 'git://github.com/guilleiguaran/active_merchant.git', :branch => 'master'
gem 'shopify'

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'therubyracer'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
