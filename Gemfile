# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.1.6'

### backend
gem 'devise', '~> 4.4.3'
gem 'jbuilder', '~> 2.7' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'pg', '~> 1.0.0'
gem 'rails_admin', '~> 1.3.0'

### assets
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'jquery-rails'
gem 'turbolinks'

### Frontend stuff
gem 'cocoon', '~> 1.2' # Use cocoon for nested forms
gem 'haml-rails', '~> 1.0'
gem 'simple_form', '~> 3.5.0'

gem 'sdoc', '~> 1.0.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'faker'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.58.2'
end

group :development do
  gem 'spring' # Spring speeds up development by keeping your application running in the background
  gem 'web-console' # Access an IRB console on exception pages or by using <%= console %> in views
end

group :test do
  gem 'simplecov', '~> 0.16'
end

### analysis
gem 'sentry-raven', '~> 2.5' # sentry for error logging

### Deployment
gem 'rails_12factor', group: :production # For Deployment to heroku

gem 'rake'
ruby '2.4.3'
