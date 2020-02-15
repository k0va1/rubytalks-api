# frozen_string_literal: true

module Parsers
  module Confreaks
    class EventParser
      attr_reader :event_page

      def initialize(event_page)
        @event_page = event_page
      end

      def call
        {
          name:       name,
          started_at: started_at,
          ended_at:   ended_at
        }
      end

      protected

      def name
        event_page.css('.event-img').text.strip.gsub(/[0-9]+/, '').strip
      end

      def started_at
        if start_month && start_day && year
          DateTime.parse("#{start_month} #{start_day} #{year}")
        else
          raise 'Could not parse :started_at'
        end
      end

      def ended_at
        if end_month && end_day && year
          DateTime.parse("#{end_month} #{end_day} #{year}")
        else
          started_at
        end
      end

      private

      def year
        event_page.css('.event-img').text.strip.scan(/.*([0-9]{4}).*/).flatten.first
      end

      def start_day
        event_page.css('.event-box').css('h4').text.scan(/([0-9]{1,2})(?<=.-([0-9]))?/).flatten.compact.first
      end

      def end_day
        event_page.css('.event-box').css('h4').text.scan(/([0-9]{1,2})(?<=.-([0-9]))?/).flatten.compact.last
      end

      def start_month
        event_page.css('.event-box').css('h4').text.scan(/\s*([A-Za-z]+)\s+\d+(?<=\s-([A-Za-z]))?/).flatten.compact.first
      end

      def end_month
        event_page.css('.event-box').css('h4').text.scan(/\s*([A-Za-z]+)\s+\d+(?<=\s-([A-Za-z]))?/).flatten.compact.last
      end
    end
  end
end
