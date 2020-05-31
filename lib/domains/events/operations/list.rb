# frozen_string_literal: true

module Domains
  module Events
    module Operations
      class List
        include Operation
        include Import[
          event_query: 'domains.events.queries.event'
        ]

        def call(params)
          events = event_query.all(params)

          Success(events)
        end
      end
    end
  end
end
