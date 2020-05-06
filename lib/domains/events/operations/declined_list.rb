# frozen_string_literal: true

module Domains
  module Events
    module Operations
      class DeclinedList
        include Operation
        include Import[
          event_repo: 'repositories.event'
        ]

        def call(input)
          talks = event_repo.all_declined(limit: input[:limit], offset: input[:offset])

          Success(talks)
        end
      end
    end
  end
end
