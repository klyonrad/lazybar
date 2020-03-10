# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.3'

gem 'rails', '~> 6.0.0'

### backend
gem 'bootsnap'
gem 'devise', '~> 4.7.1'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.2.0'
gem 'rails_admin', '~> 2.0.0.beta'

### assets
gem 'coffee-rails', '~> 5.0'
gem 'jquery-rails'
gem 'sass-rails', '~> 6.0'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

### Frontend stuff
gem 'cocoon', '~> 1.2'
gem 'haml-rails', '~> 2.0'
gem 'simple_form', '~> 4.1.0'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :test do
  gem 'coveralls', require: false
  gem 'factory_bot_rails', '~> 5.0.2'
  gem 'faker'
  gem 'rails-dom-testing'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
end

### analysis
gem 'sentry-raven', '~> 3.0'

### Deployment
gem 'rails_12factor', group: :production # For Deployment to heroku

gem 'rake'
