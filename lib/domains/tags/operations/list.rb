# frozen_string_literal: true

module Domains
  module Tags
    module Operations
      class List
        include Operation
        include Import[
          tag_query: 'domains.tags.queries.tag'
        ]

        def call(input)
          tags = tag_query.all(input)

          Success(tags)
        end
      end
    end
  end
end
