# frozen_string_literal: true

module Domains
  module Tags
    module Queries
      class Tag
        include Import[
          repo: 'repositories.tag'
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
