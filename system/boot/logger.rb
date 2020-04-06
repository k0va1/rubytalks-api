# frozen_string_literal: true

Hanami::Container.boot(:my_logger) do |app|
  init do
    use :dotenv

    SemanticLogger.default_level = ENV.fetch('LOGGER_LEVEL')
    SemanticLogger.add_appender(io: $stdout, formatter: :color)
    app.register(:my_logger, SemanticLogger['RubyTalks'])
  end
end
