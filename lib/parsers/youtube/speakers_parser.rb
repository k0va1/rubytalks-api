# frozen_string_literal: true

module Parsers
  module Youtube
    class SpeakersParser
      include Import[
        slug_generator: 'util.slug_generator',
        nlp_client: 'util.client.nlp',
        logger: 'app_logger'
      ]

      def initialize(item, *args)
        @item = item
        super(*args)
      end

      def call
        speakers.map do |full_name|
          splitted_name = full_name.split
          next if splitted_name.length == 1

          {
            first_name: first_name(splitted_name),
            middle_name: middle_name(splitted_name),
            last_name: last_name(splitted_name),
            slug: slug(full_name)
          }
        end.compact
      end

      private

      def first_name(splitted_name)
        splitted_name.first.capitalize
      end

      def middle_name(splitted_name)
        splitted_name[1...-1].join(' ').capitalize if splitted_name.length > 2
      end

      def last_name(splitted_name)
        splitted_name.last.capitalize
      end

      def slug(full_name)
        slug_generator.call(full_name)
      end

      def speakers
        @speakers ||= begin
                        nlp_client.fetch_people(item.snippet.title)
                      rescue Util::Client::NlpClientError => e
                        logger.info("Couldn't parse speakers from title: #{item.snippet.title}")
                        []
                      end
      end

      attr_reader :item
    end
  end
end
