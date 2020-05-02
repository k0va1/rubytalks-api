# frozen_string_literal: true

module Util
  class SlugGenerator
    UNSUPPORTED_SYMBOLS = /[^A-Za-z0-9\-]/.freeze

    def call(*args)
      args.to_a.compact.flatten.map(&:split).join('-').downcase.gsub(UNSUPPORTED_SYMBOLS, '')
    end
  end
end
