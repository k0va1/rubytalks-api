# frozen_string_literal: true

module Parsers
  module Confreaks
    class SpeakerParser
      attr_reader :speaker_block, :splitted_name

      def initialize(speaker_block)
        @speaker_block = speaker_block
        @splitted_name = speaker_block.text.strip.split
      end

      def call
        {
          first_name:  first_name,
          middle_name: middle_name,
          last_name:   last_name,
          slug:        slug
        }
      end

      protected

      def first_name
        splitted_name[0]
      end

      def middle_name
        middle_name_exists? ? splitted_name[1] : nil
      end

      def last_name
        middle_name_exists? ? splitted_name[2] : splitted_name[1]
      end

      def slug
        [first_name, middle_name, last_name].join('-')
      end

      private

      def middle_name_exists?
        splitted_name.length == 3
      end
    end
  end
end
