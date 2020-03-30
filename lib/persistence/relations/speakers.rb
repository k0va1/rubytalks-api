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
    end
  end
end
