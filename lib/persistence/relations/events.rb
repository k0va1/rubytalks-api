# frozen_string_literal: true

module Persistence
  module Relations
    class Events < ROM::Relation[:sql]
      schema(:events, infer: true) do
        associations do
          has_many :talks
        end
      end

      def with_state(state)
        where(state: state)
      end

      def search(query)
        where { Sequel.lit(['', ' @@ ', ''], string.to_tsvector(name), string.phraseto_tsquery(query)) }
      end
    end
  end
end
