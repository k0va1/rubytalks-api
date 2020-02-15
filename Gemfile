# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.3'

gem 'hanami', '~> 2.0.0.alpha1'
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

# generate embed from url
gem 'ruby-oembed'

# xml parser
gem 'nokogiri'

# background jobs
gem 'hiredis'
gem 'sidekiq'
gem 'sidekiq-cron'

group :development do
  # code style
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'database_cleaner'
  # fake data
  gem 'faker'
  # debug
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
  gem 'rom-factory'
  gem 'json_matchers'
  gem 'webmock'
end

group :production do
  gem 'puma'
end
