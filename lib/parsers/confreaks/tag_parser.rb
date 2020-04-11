# frozen_string_literal: true

module Parsers
  module Confreaks
    class TagParser
      include Import[
        slug_generator: 'util.slug_generator'
      ]

      attr_reader :tag_block

      def initialize(tag_block, *args)
        @tag_block = tag_block
        super(*args)
      end

      def call
        {
          title: title,
          slug: slug
        }
      end

      private

      def title
        tag_block.text.downcase.strip
      end

      def slug
        slug_generator.call(title)
      end
    end
  end
end
