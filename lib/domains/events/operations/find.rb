# frozen_string_literal: true

module Domains
  module Events
    module Operations
      class Find
        include Operation
        include Import[
          event_repo: 'repositories.event'
        ]

        def call(id:)
          talk = Try(ROM::TupleCountMismatchError) { event_repo.find_by_id_with_talks(id: id) }
          talk.to_result
        end
      end
    end
  end
end
