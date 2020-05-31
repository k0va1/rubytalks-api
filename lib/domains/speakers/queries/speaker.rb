# frozen_string_literal: true

module Domains
  module Speakers
    module Queries
      class Speaker
        include Import[
          repo: 'repositories.speaker'
        ]

        def all(params)
          relation = repo.root

          relation = relation.with_state(params[:state]) if params[:state]
          relation = relation.search(params[:query]) if params[:query]
          repo.apply_pagination(relation, params[:offset], params[:limit]).one!
        end
      end
    end
  end
end
