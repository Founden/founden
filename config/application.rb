require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# Bundler.require(:default, Rails.env)
# See https://github.com/rails/rails/commit/49c4af43ec5819d8f5c1a91f9b84296c927ce6e7
Bundler.require(*Rails.groups(assets: %w[development test]))

module Founden
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure generators
    config.generators do |g|
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :fabrication
      g.view_specs          false
      g.helper              false
      g.helper_specs        false
      g.stylesheets         false
      g.javascripts         false
    end
  end

  # Our settings management class
  class Config < ReadWriteSettings
    if Rails.root.join('config', 'settings.yml').exist?
      source Rails.root.join('config', 'settings.yml').to_s
    else
      source Rails.root.join('config', 'settings.yml.example').to_s
    end
    namespace Rails.env
  end
end
