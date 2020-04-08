# frozen_string_literal: true

module Persistence
  module Relations
    class Taggings < ROM::Relation[:sql]
      schema(:taggings, infer: true) do
        associations do
          belongs_to :talk
          belongs_to :tag
        end
      end
    end
  end
end
