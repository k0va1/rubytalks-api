# frozen_string_literal: true

module Domains
  module Tags
    module Operations
      class UnpublishedList
        include Operation
        include Import[
          tag_repo: 'repositories.tag'
        ]

        def call(input)
          tags = tag_repo.all_unpublished(limit: input[:limit], offset: input[:offset])

          Success(tags)
        end
      end
    end
  end
end
