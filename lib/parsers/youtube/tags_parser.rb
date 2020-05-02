# frozen_string_literal: true

module Parsers
  module Youtube
    class TagsParser
      include Import[
        slug_generator: 'util.slug_generator'
      ]

      def initialize(item, *args)
        @item = item
        super(*args)
      end

      def call
        tags.map do |tag|
          {
            title: tag.downcase,
            slug: slug_generator.call(tag)
          }
        end
      end

      private

      def tags
        item.snippet.description.scan(/#(\w+)/).flatten
      end

      attr_reader :item
    end
  end
end
