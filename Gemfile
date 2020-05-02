# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.3'

gem 'hanami', '2.0.0.alpha1'
gem 'rake'

gem 'rom'
gem 'rom-sql'

gem 'pg'

gem 'xml-sitemap'

gem 'multi_json'
gem 'oj'
gem 'representable'

# dry stuff
gem 'dry-monads', '~> 1.1.0'
gem 'dry-validation'

# logging
gem 'awesome_print'
gem 'semantic_logger'
gem 'sentry-raven'

# generate embed from url
gem 'ruby-oembed'

# xml parser
gem 'nokogiri'

gem 'google-api-client'

gem 'bcrypt'
gem 'jwt'
gem 'warden'

# background jobs
gem 'hiredis'
gem 'sidekiq'
gem 'sidekiq-cron'

group :development do
  gem 'guard-puma'
  # code style
  gem 'rubocop', require: false
  gem 'rubocop-faker'
  gem 'rubocop-rspec'
end

group :test, :development do
  gem 'database_cleaner'
  gem 'dotenv', '~> 2.4'
  # fake data
  gem 'faker'
  # debug
  gem 'pry-byebug'
end

group :test do
  gem 'json_matchers'
  gem 'rom-factory'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
  gem 'webmock'
end

group :production do
  gem 'puma'
end

group :plugins do
  gem 'hanami-reloader', '~> 1.0.0.alpha1'
end
