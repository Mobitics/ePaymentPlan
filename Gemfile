source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'
gem 'rake', '= 0.8.7'
#gem 'sass'
#gem 'coffee-script'
#gem 'uglifier'
gem 'jquery-rails'
gem 'pjax-rails'
gem 'activemerchant', :git => 'git://github.com/guilleiguaran/active_merchant.git', :branch => 'epaymentplan'
gem 'shopify_api'

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rspec-rails', '2.6.1.beta1'
  gem 'autotest'
  gem 'rcov'
  gem 'factory_girl_rails'
  gem 'factory_girl'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'unicorn'
  gem 'pg'
  #gem 'therubyracer'
end
