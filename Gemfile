source 'https://rubygems.org'

gem 'rails', '~> 5.1.2'

### backend
gem 'pg', '~> 0.18.4'
gem 'jbuilder', '~> 2.7' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'devise', '~> 4.3.0'
gem 'rails_admin', '~> 1.2.0'

### assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.2'
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'jquery-rails'
gem 'turbolinks'


### Frontend stuff
gem 'simple_form', '~> 3.5.0'
gem 'cocoon', '~> 1.2' # Use cocoon for nested forms

gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console' # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'pry-rails'
  gem 'spring' # Spring speeds up development by keeping your application running in the background
end

### analysis
gem 'sentry-raven', '~> 2.5' # sentry for error logging

### Deployment
gem 'rails_12factor', group: :production # For Deployment to heroku

gem 'rake', '~> 12.0'
ruby '2.3.3'
