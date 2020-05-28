# frozen_string_literal: true

module Persistence
  module Relations
    class Tags < ROM::Relation[:sql]
      schema(:tags, infer: true) do
        associations do
          has_many :taggings
          has_many :talks, through: :taggings
        end
      end

      def with_state(state)
        where(state: state)
      end

      def search(query)
        where { Sequel.lit(["", " @@ ", ""], string.to_tsvector(title), string.phraseto_tsquery(query)) }
      end
    end
  end
end
