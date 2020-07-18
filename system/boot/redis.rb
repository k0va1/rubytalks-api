# frozen_string_literal: true

Hanami::Container.boot(:redis) do |_container|
  init do
    require 'dotenv' if defined?(Dotenv)

    redis = ConnectionPool.new(size: 10, timeout: 3) do
      Redis.new(url: ENV.fetch('REDIS_URL'))
    end

    # ping redis DB before start for understanding that all works correctly
    redis.with(&:ping)

    register(:redis, redis)
  end
end
