require_relative "boot"

require "rails/all"
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV["RAILS_ENV"] ||= ENV["RACK_ENV"] ||= "production"
Dotenv.load ".env.#{ENV["RAILS_ENV"]}", '.env'

module PowerdnsOnRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    
    config.time_zone = "Berlin"
    
    config.encoding = "utf-8"
    
    config.filter_parameters += [:password, :login, :email]
    
    config.eager_load_paths << Rails.root.join("lib")
  end
end
