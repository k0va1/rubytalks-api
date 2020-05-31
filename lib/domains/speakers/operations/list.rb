# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class List
        include Operation
        include Import[
          speaker_query: 'domains.speakers.queries.speaker'
        ]

        def call(params)
          speakers = speaker_query.all(params)

          Success(speakers)
        end
      end
    end
  end
end
