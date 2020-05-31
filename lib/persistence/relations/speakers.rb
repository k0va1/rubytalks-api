# frozen_string_literal: true

module Persistence
  module Relations
    class Speakers < ROM::Relation[:sql]
      schema(:speakers, infer: true) do
        associations do
          has_many :speakings
          has_many :talks, through: :speakings
        end
      end

      def with_state(state)
        where(state: state)
      end

      def search(query)
        where do
          Sequel.lit(
            ['', ' @@ ', ''],
            string.to_tsvector(first_name),
            string.phraseto_tsquery(query)
          ) |
            Sequel.lit(
              ['', ' @@ ', ''],
              string.to_tsvector(last_name),
              string.phraseto_tsquery(query)
            )
        end
      end
    end
  end
end
