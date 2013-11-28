# A sample Gemfile
source 'https://rubygems.org'

gem 'rails'
gem 'pg'
gem 'rubysl', :platform => 'rbx'
gem 'easy_auth', :github => 'dockyard/easy_auth'
gem 'readwritesettings'
gem 'haml-rails'
gem 'gettext_i18n_rails'

group :assets do
  gem 'sprockets-rails'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'therubyracer'
  gem 'jquery-rails'
  gem 'bourbon'
  gem 'normalize-rails'
end

group :development do
  gem 'quiet_assets'
  gem 'pry-rails'
end

group :development, :test do
  gem 'ffaker'
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'guard-rspec', :require => false
  gem 'guard-migrate', :require => false
end

group :test do
  gem 'database_rewinder'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
end
