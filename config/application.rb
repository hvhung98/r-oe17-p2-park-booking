require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module ParkBooking
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en]
  end
end