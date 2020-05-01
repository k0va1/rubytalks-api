# frozen_string_literal: true

require 'hanami/container'
require_relative './container_ext/file_registration'

Hanami::Container.load_paths!('lib')

Hanami::Container.extend(ContainerExt::FileRegistration)

Hanami::Container.configure do |config|
  config.auto_register = %w[
    lib/repositories
    lib/domains
    lib/util
    lib/parsers
  ]
end

if ENV['HANAMI_ENV'] == 'test'
  require 'dry/container/stub'
  Hanami::Container.enable_stubs!
end

require_relative 'import'
