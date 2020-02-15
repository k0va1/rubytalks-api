# frozen_string_literal: true

Hanami::Container.boot(:sidekiq) do |container|
  init do
    use :redis

    Sidekiq.configure_server do |config|
      config.redis = container[:redis]
    end

    Sidekiq.configure_client do |config|
      config.redis = container[:redis]
    end

    schedule_file = 'config/schedule.yml'

    if File.exist?(schedule_file) && Sidekiq.server?
      Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file))
    end
  end
end
