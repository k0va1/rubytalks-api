# frozen_string_literal: true

# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require 'support/simplecov'
require 'faker'

require 'bundler/setup'
require 'hanami'

Bundler.require(:default, :test)

require_relative '../config/application'

Hanami.boot

require 'support/rom_factory'

Hanami::Utils.require!("#{__dir__}/support")

require 'support/database_cleaner'
require 'json_matchers/rspec'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

JsonMatchers.schema_root = 'spec/support/json_schemas'

RSpec.configure do |config|
  config.include Dry::Monads::Result::Mixin
  config.include RequestHelpers, type: :request
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
