# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class DeclinedList
        include Operation
        include Import[
          speaker_repo: 'repositories.speaker'
        ]

        def call(input)
          talks = speaker_repo.all_declined(limit: input[:limit], offset: input[:offset])

          Success(talks)
        end
      end
    end
  end
end
