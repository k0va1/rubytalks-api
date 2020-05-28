# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class List
        include Operation
        include Import[
          talk_query: 'domains.talks.queries.talk'
        ]

        def call(input)
          talks = talk_query.all(input)

          Success(talks)
        end
      end
    end
  end
end
