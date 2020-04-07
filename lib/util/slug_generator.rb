# frozen_string_literal: true

module Util
  class SlugGenerator
    def call(*args)
      args.to_a.compact.flatten.map(&:split).join('-').downcase
    end
  end
end
