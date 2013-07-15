source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.beta1'

gem 'pg'

gem 'omniauth'
gem 'omniauth-meetup'

gem 'slim-rails'

gem 'httparty'

gem 'virtus'

gem 'pry'

gem 'sass-rails',   '~> 4.0.0.beta1'
gem 'coffee-rails', '~> 4.0.0.beta1'

# Gems used only for assets and not required
# in production environments by default.
group :production, :assets do
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier', '>= 1.0.3'
end

# not using jquery-rails and jquery-ui-sass-rails because we're using bower now

# Turbolinks makes following links in your web application faster. Read more:
# https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

group :development do
  gem 'capistrano'
  gem 'annotate'
  gem 'simplecov'
  gem 'better_errors'
  gem 'binding_of_caller'
  # To use debugger
  gem 'debugger'
end

group :test do
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'timecop'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
end
