# frozen_string_literal: true

# TODO: not needed anymore? controller tests are deprecated
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  # config.include Devise::TestHelpers, type: :controller
  # config.include Warden::Test::Helpers, type: :request
  config.include Devise::Test::ControllerHelpers, type: :view
end
