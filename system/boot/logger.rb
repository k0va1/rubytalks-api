# frozen_string_literal: true

Hanami::Container.boot(:my_logger) do |app|
  start do
    SemanticLogger.default_level = :debug
    SemanticLogger.add_appender(io: $stdout, formatter: :color)
    app.register(:my_logger, SemanticLogger['RubyTalks'])
  end
end
