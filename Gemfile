# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.2.1'

### backend
gem 'devise', '~> 4.5.0'
gem 'jbuilder', '~> 2.7' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'pg', '~> 1.0.0'
gem 'rails_admin', '~> 1.4.1'

### assets
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks'

### Frontend stuff
gem 'cocoon', '~> 1.2' # Use cocoon for nested forms
gem 'haml-rails', '~> 1.0'
gem 'simple_form', '~> 4.0.1'

gem 'sdoc', '~> 1.0.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.

group :development, :test do
  gem 'factory_bot_rails', '~> 4.11.0'
  gem 'faker'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.58.2'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
end

group :test do
  gem 'simplecov', '~> 0.16'
end

### analysis
gem 'sentry-raven', '~> 2.5'

### Deployment
gem 'rails_12factor', group: :production # For Deployment to heroku

gem 'rake'
# ruby '2.4.3'
