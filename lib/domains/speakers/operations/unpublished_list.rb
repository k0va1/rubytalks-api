# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class UnpublishedList
        include Operation
        include Import[
          speaker_repo: 'repositories.speaker'
        ]

        def call(input)
          speakers = speaker_repo.all_unpublished(limit: input[:limit], offset: input[:offset])

          Success(speakers)
        end
      end
    end
  end
end
