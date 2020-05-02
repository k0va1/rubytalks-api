# frozen_string_literal: true

module Parsers
  module Youtube
    class TalkParser
      include Import[
        slug_generator: 'util.slug_generator'
      ]

      def initialize(item, *args)
        @item = item
        super(*args)
      end

      def call
        {
          title: title,
          description: description,
          talked_at: talked_at,
          link: link,
          slug: slug,
          source: 'youtube',
          source_id: video_id
        }
      end

      private

      def title
        item.snippet.title
      end

      def description
        normalize_description(item.snippet.description)
      end

      def link
        "https://www.youtube.com/watch?v=#{video_id}"
      end

      def slug
        slug_generator.call(title)
      end

      # TODO: somehow fetch talked_at
      def talked_at
        DateTime.now
      end

      def video_id
        item.content_details.video_id
      end

      def normalize_description(description)
        description.gsub(/\#\w+/, '').strip
      end

      attr_reader :item
    end
  end
end
