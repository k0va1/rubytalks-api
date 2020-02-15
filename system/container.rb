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
  ]
end

require_relative 'import'
