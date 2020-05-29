# frozen_string_literal: true

require 'hanami/container'
require_relative './container_ext/file_registration'

Hanami::Container.load_paths!('lib')

Hanami::Container.extend(ContainerExt::FileRegistration)

Hanami::Container.configure do |config|
  config.auto_register = %w[
    lib/repositories
    lib/domains
    lib/parsers
  ]
end

# use telegram mock in development
# don't like this. mb better solution exists
Hanami::Container.auto_register!('lib/util') do |cfg|
  cfg.exclude do |component|
    component.identifier == "util.client.telegram" if ENV['HANAMI_ENV'] == 'development'
  end
end

if ENV['HANAMI_ENV'] == 'development'
  require_relative '../lib/util/client/telegram'
  Hanami::Container.register('util.client.telegram', Util::Client::TelegramMock.new)
end

if ENV['HANAMI_ENV'] == 'test'
  require 'dry/container/stub'
  Hanami::Container.enable_stubs!
end

require_relative 'import'
