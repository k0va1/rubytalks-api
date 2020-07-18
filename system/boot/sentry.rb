# frozen_string_literal: true

Hanami::Container.boot(:sentry) do |_container|
  init do
    require 'dotenv' if defined?(Dotenv)
  end

  start do
    Raven.configure do |config|
      config.dsn           = ENV['SENTRY_DSN']
      config.timeout       = 10
      config.open_timeout  = 10
      config.environments  = %w[production]
      config.silence_ready = true
    end

    register(:sentry, Raven)
  end
end
