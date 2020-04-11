# frozen_string_literal: true

require 'open-uri'

module Domains
  module Talks
    module Operations
      module Importer
        class Confreaks
          include Operation
          include Import[
            talk_repo: 'repositories.talk',
            speaker_repo: 'repositories.speaker',
            event_repo: 'repositories.event',
            speaking_repo: 'repositories.speaking',
            tag_repo: 'repositories.tag',
            tagging_repo: 'repositories.tagging'
          ]

          CONFREAKS_URL = 'https://confreaks.tv'
          BUZZWORDS = %w[ruby rails goruco .rb euruko].freeze

          # TODO: return Success or Failure
          def call # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
            (1..total_pages).each do |page| # rubocop: disable Metrics/BlockLength
              html_page = get_parsed_page("#{CONFREAKS_URL}/?page=#{page}")
              ruby_events = select_ruby_events(html_page)

              ruby_events.each do |ruby_event| # rubocop: disable Metrics/BlockLength
                event_url = "#{CONFREAKS_URL}#{ruby_event.css('.event-img').css('/a').first.attr(:href)}"
                event_page = get_parsed_page(event_url)

                event_hash = Parsers::Confreaks::EventParser.new(ruby_event).call
                event = event_repo.find_or_create(event_hash)

                event_page.css('.video').each do |talk_item|
                  talk_url = talk_item.css('.video-image').css('/a').first&.attr(:href)
                  talk_page = get_parsed_page("#{CONFREAKS_URL}#{talk_url}")

                  speaker_list = talk_page.css('.video-presenters').css('/a').map do |speaker_link|
                    Parsers::Confreaks::SpeakerParser.new(speaker_link).call
                  end
                  talk_hash = Parsers::Confreaks::TalkParser.new(talk_item, talk_page).call
                  tags_list = talk_page.css('.video-bottom-info-middle').css('.tag').map do |tag|
                    Parsers::Confreaks::TagParser.new(tag).call
                  end

                  talk_repo.transaction do
                    talk = talk_repo.find_or_create(talk_hash.merge(event_id: event&.id))
                    speaker_list.each do |speaker_hash|
                      speaker = speaker_repo.find_or_create(speaker_hash)
                      speaking_repo.find_or_create(speaker_id: speaker.id, talk_id: talk.id)
                    end
                    tags_list.each do |tag_hash|
                      tag = tag_repo.find_or_create(tag_hash)
                      tagging_repo.find_or_create(tag_id: tag.id, talk_id: talk.id)
                    end
                  end
                end
              end
            end
          end

          private

          def total_pages
            document = get_parsed_page(CONFREAKS_URL)
            document.css('.pagination').first.css('a')[8].text.to_i
          end

          def select_ruby_events(html_page)
            event_nodes = html_page.css('.event-isotope')
            event_nodes.select do |event_node|
              conf_name = event_node.css('.event-img').text.strip.downcase
              BUZZWORDS.any? { |word| conf_name.include?(word) } && !event_without_videos?(event_node)
            end
          end

          def event_without_videos?(event_node)
            ['presentations available on youtube', '0 available presentations'].any? do |text|
              event_node.css('.text-muted')
                        .text
                        .downcase
                        .include?(text)
            end
          end

          def get_parsed_page(url)
            Nokogiri::HTML(URI.open(url, read_timeout: 30, open_timeout: 30))
          end
        end
      end
    end
  end
end
