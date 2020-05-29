# frozen_string_literal: true

module Parsers
  module Youtube
    class Parser
      attr_reader :talk, :speakers, :tags, :event

      def call(item, playlist = nil)
        parse_talk(item)
        parse_speakers(item)
        parse_tags(item)
        parse_event(item, playlist)
        normalize_talk_title
      end

      private

      def parse_talk(item)
        @talk = Parsers::Youtube::TalkParser.new(item).call
      end

      def parse_speakers(item)
        @speakers = Parsers::Youtube::SpeakersParser.new(item).call
      end

      def parse_tags(item)
        @tags = Parsers::Youtube::TagsParser.new(item).call
      end

      def parse_event(item, playlist)
        @event = Parsers::Youtube::EventParser.new(item, playlist).call
      end

      def normalize_talk_title
        remove_event_name if Hanami::Utils::Blank.filled?(event)
      end

      def remove_event_name
        talk.update(title: talk[:title].gsub(/#{event[:name]}\s*(-|:)?\s*/, ''))
      end
    end
  end
end
