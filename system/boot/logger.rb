# frozen_string_literal: true

# # frozen_string_literal: true
#
# Container.boot(:logger) do |container|
#   # init do
#   #   if ENV['LOGGER_JSON_FORMATTER']
#   #     SemanticLogger.add_appender(io: logger_io, formatter: :json)
#   #   else
#   #     SemanticLogger.add_appender(io: logger_io)
#   #   end
#   #
#   #   SemanticLogger.default_level = :debug
#   #
#   #   container.register(:logger, SemanticLogger['RubyTalks'])
#   # end
#   # #
#   # # # detect default logger IO output
#   # def logger_io
#   #   Hanami.env == 'test' ? StringIO.new : STDOUT
#   # end
# end
