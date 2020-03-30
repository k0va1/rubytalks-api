# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class Find
        include Operation
        include Import[
          talk_repo: 'repositories.talk'
        ]

        def call(id:)
          talk = Try(ROM::TupleCountMismatchError) { talk_repo.find_by_id_with_speakers_and_event(id) }
          talk.to_result
        end
      end
    end
  end
end
