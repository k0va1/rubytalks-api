# frozen_string_literal: true

Hanami::Container.boot(:app_logger) do |app|
  init do
    use :dotenv

    SemanticLogger.default_level = ENV.fetch('LOGGER_LEVEL')
    SemanticLogger.add_appender(io: $stdout, formatter: :color)
    app.register(:app_logger, SemanticLogger['RubyTalks'])
  end
end
