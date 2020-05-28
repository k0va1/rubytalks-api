# frozen_string_literal: true

module Util
  class SlugGenerator
    UNSUPPORTED_SYMBOLS = /[^A-Za-z0-9\-]/.freeze

    def call(*args)
      args.to_a.flatten.select do |e|
        Hanami::Utils::Blank.filled?(e)
      end.map(&:split).join('-').downcase.gsub(UNSUPPORTED_SYMBOLS, '')
    end
  end
end
