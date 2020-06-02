# frozen_string_literal: true

module Domains
  module Talks
    module Workers
      class YoutubeImport
        include Dry::Monads::Result::Mixin
        include Sidekiq::Worker

        include Import[
          operation: 'domains.talks.operations.importer.youtube',
          logger: 'app_logger'
        ]

        def perform
          result = operation.call

          case result
          when Success
            # TODO: log some info about how many talks, events and speakers have been imported
            # kind of ImportStatistics or smth.
            logger.info('Talks have successfully imported')
          when Failure
            logger.error('Could not import talks from youtube.')
            logger.error(result.failure)
          end
        end
      end
    end
  end
end
