# frozen_string_literal: true

module Parsers
  module Youtube
    class EventParser
      include Import[
        slug_generator: 'util.slug_generator'
      ]

      def initialize(item, playlist, *args)
        @item = item
        @playlist = playlist
        super(*args)
      end

      def call
        return unless name

        {
          name: name,
          slug: slug
        }
      end

      private

      def name
        return @name if defined?(@name)
        return @name = playlist.snippet.title.strip if playlist

        item.snippet.title.match(/^(.*\d{4}).*/)
        @name = Regexp.last_match(1)
      end

      def slug
        slug_generator.call(name)
      end

      attr_reader :item, :playlist
    end
  end
end
