# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class ApprovedList
        include Operation
        include Import[
          talk_repo: 'repositories.talk'
        ]

        def call(input)
          talks = talk_repo.all_approved(limit: input[:limit], offset: input[:offset])

          Success(talks)
        end
      end
    end
  end
end
