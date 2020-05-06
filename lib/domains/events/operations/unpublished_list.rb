# frozen_string_literal: true

module Domains
  module Events
    module Operations
      class UnpublishedList
        include Operation
        include Import[
          event_repo: 'repositories.event'
        ]

        def call(input)
          events = event_repo.all_unpublished(limit: input[:limit], offset: input[:offset])

          Success(events)
        end
      end
    end
  end
end
