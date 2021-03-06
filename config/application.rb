# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LazyBar
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.action_controller.action_on_unpermitted_parameters = :raise
    # just to remove the deprecation warning
    config.action_dispatch.return_only_media_type_on_content_type = false

    config.generators do |g|
      g.test_framework :rspec, view_specs: false, helper_specs: false, routing_specs: false
    end
  end
end
