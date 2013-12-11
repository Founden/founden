# A sample Gemfile
source 'https://rubygems.org'

gem 'rails'
gem 'pg'
gem 'rubysl', :platform => 'rbx'
gem 'easy_auth', :github => 'dockyard/easy_auth'
gem 'easy_auth-oauth2', :github => 'stas/easy_auth-oauth2', :branch => 'update_to_easy_auth_master'
gem 'easy_auth-google', :github => 'stas/easy_auth-google'
gem 'readwritesettings'
gem 'haml-rails'
gem 'gettext_i18n_rails'
gem 'activerecord-session_store'
gem 'friendly_id'
gem 'sanitize'
gem 'paperclip'
gem 'active_model_serializers', :github => 'stas/active_model_serializers', :branch => 'fork'

group :development do
  gem 'quiet_assets'
  gem 'pry-rails'
end

group :production do
  gem 'puma'
  gem 'bugsnag', :require => 'bugsnag/railtie'
end

# See why https://github.com/rails/rails/commit/49c4af43ec
group :development, :assets, :test, :production do
  gem 'sprockets-rails'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'therubyracer'
  gem 'jquery-rails'
  gem 'bourbon'
  gem 'normalize-rails'
  gem 'ember-rails'
  gem 'ember-source', '~> 1.3.0.beta'
  gem 'ember-data-source', '~> 1.0.0.beta'
  gem 'hamlbars'
  gem 'momentjs-rails'
end

group :development, :test do
  gem 'ffaker'
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'guard-rspec', :require => false
  gem 'guard-migrate', :require => false
  gem 'capistrano-rails', :require => false
  gem 'capistrano-rbenv', :require => false
  gem 'capistrano-puma', :require => false
end

group :test do
  gem 'vcr'
  gem 'poltergeist'
  gem 'database_rewinder'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
  gem 'capybara-puma'
end
