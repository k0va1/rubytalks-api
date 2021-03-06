# frozen_string_literal: true

Hanami::Container.boot(:rom) do |app|
  init do
    require 'dotenv' if defined?(Dotenv)
  end

  start do
    container = ROM.container(:sql, ENV.fetch('DATABASE_URL')) do |config|
      config.auto_registration(app.root.join('lib/persistence'))
      config.plugin(:sql, relations: :pagination)
      config.gateways[:default].use_logger(app[:app_logger])
    end

    register(:rom, container)
  end
end
