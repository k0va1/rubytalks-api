# frozen_string_literal: true

module Domains
  module Events
    module Operations
      class FindApproved
        include Operation
        include Import[
          event_repo: 'repositories.event'
        ]

        def call(id:)
          event = Try(ROM::TupleCountMismatchError) { event_repo.find_with_talks(id: id) }
                  .or { Failure(:not_found) }
          event.to_result
        end
      end
    end
  end
end
