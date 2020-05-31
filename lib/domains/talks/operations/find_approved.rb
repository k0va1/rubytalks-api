# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class FindApproved
        include Operation
        include Import[
          talk_repo: 'repositories.talk'
        ]

        def call(id:)
          talk = Try(ROM::TupleCountMismatchError) { talk_repo.find_approved_by_id_with_speakers_and_event(id) }
                 .or { Failure(:not_found) }
          talk.to_result
        end
      end
    end
  end
end
