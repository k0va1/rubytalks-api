# frozen_string_literal: true

module Parsers
  module Confreaks
    class TalkParser
      class UndefinedLinkProviderError < StandardError; end

      attr_reader :event_page, :talk_page

      HASH_REGEX = %r{.*(?:video|embed)/([A-Za-z0-9\-_]+).*}.freeze

      def initialize(event_page, talk_page)
        @event_page = event_page
        @talk_page  = talk_page
      end

      def call
        {
          title: title,
          description: description,
          talked_at: talked_at,
          link: link,
          source: source,
          source_id: source_id
        }
      end

      protected

      def title
        talk_page.css('.video-title').css('/a').text.strip
      end

      def description
        talk_page.css('.video-stats').text.strip
      end

      def talked_at
        DateTime.parse(event_page.css('.video-posted').first.css('strong').text.strip)
      rescue TypeError, ArgumentError
        nil
      end

      def link
        html_link = talk_page.css('iframe').first&.attr(:src)
        @hash = html_link.scan(HASH_REGEX).flatten.first

        if youtube_link?(html_link)
          @source = 'youtube'
          "https://www.youtube.com/watch?v=#{@hash}"
        elsif vimeo_link?(html_link)
          @source = 'vimeo'
          "https://vimeo.com/#{@hash}"
        else
          raise UndefinedLinkProviderError, "Unprocessable link: #{html_link}"
        end
      end

      def source
        @source if defined?(@source)
      end

      def source_id
        @hash if defined?(@hash)
      end

      private

      def youtube_link?(link)
        link.include?('youtube')
      end

      def vimeo_link?(link)
        link.include?('vimeo')
      end
    end
  end
end
