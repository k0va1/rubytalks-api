# frozen_string_literal: true

module Domains
  module Talks
    module Workers
      class ConfreaksImport
        include Dry::Monads::Result::Mixin
        include Sidekiq::Worker

        include Import[
          :logger,
          operation: 'domains.talks.operations.importer.confreaks'
        ]

        def perform
          result = operation.call

          case result
          when Success
            # TODO: log some info about how many talks, events and speakers have been imported
            logger.info('Talks have successfully imported')
          when Failure
            logger.error('Could not import talks from confreaks.')
          end
        end
      end
    end
  end
end
