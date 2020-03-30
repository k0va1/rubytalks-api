# frozen_string_literal: true

module Persistence
  module Relations
    class Speakings < ROM::Relation[:sql]
      schema(:speakings, infer: true) do
        associations do
          belongs_to :talk
          belongs_to :speaker
        end
      end
    end
  end
end
