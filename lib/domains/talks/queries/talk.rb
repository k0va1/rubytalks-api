# frozen_string_literal: true

module Domains
  module Talks
    module Queries
      class Talk
        include Import[
          repo: 'repositories.talk'
        ]

        def all(params)
          relation = repo.talks

          relation = relation.combine(:speakers, :event, :tags)
          relation = relation.with_state(params[:state]) if params[:state]
          relation = relation.search(params[:query]) if params[:query]
          repo.apply_pagination(relation, params[:offset], params[:limit]).one!
        end
      end
    end
  end
end
