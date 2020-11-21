# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class Approve
        include Operation
        include Import[
          speaker_repo: 'repositories.speaker'
        ]

        def call(id)
          Try(ROM::TupleCountMismatchError) do
            speaker_repo.update(id, state: Types::States[:approved])
            speaker_repo.find_by_id_with_talks(id: id)
          end.to_result
        end
      end
    end
  end
end
