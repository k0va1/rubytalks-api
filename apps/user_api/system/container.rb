# frozen_string_literal: true

require 'dry/system/container'

module UserApi
  class Container < Dry::System::Container
    setting :path_prefix

    configure do |config|
      config.path_prefix = Pathname('apps/user_api')
      config.auto_register = %w[services].map do |dir|
        config.path_prefix.join(dir)
      end
    end

    load_paths! Hanami.root.join('apps')
  end
end
