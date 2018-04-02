# frozen_string_literal: true

if Rails.env.production?
  Raven.configure do |config|
    config.dsn          = Rails.application.secrets.sentry_dsn
    config.environments = ['production']
  end
end
