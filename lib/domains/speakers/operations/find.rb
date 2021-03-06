# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class Find
        include Operation
        include Import[
          speaker_repo: 'repositories.speaker'
        ]

        def call(id:)
          speaker = Try(ROM::TupleCountMismatchError) { speaker_repo.find_by_id_with_talks(id: id) }
          speaker.to_result
        end
      end
    end
  end
end
