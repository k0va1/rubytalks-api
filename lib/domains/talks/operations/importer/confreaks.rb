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
            talk_speaker_repo: 'repositories.talks_speaker',
          ]

          CONFREAKS_URL = 'https://confreaks.tv'
          BUZZWORDS = %w[ruby rails goruco .rb euruko].freeze

          # TODO: return Success or Failure
          def call
            document = get_parsed_page(CONFREAKS_URL)
            total_pages = document.css('.pagination').first.css('a')[8].text.to_i

            (1..total_pages).each do |page|
              html_page = get_parsed_page("#{CONFREAKS_URL}/?page=#{page}")
              ruby_events = select_ruby_events(html_page)

              ruby_events.each_with_index do |ruby_event, i|
                event_url = "#{CONFREAKS_URL}#{ruby_event.css('.event-img').css('/a').first.attr(:href)}"
                event_page = get_parsed_page(event_url)

                event_page.css('.video').each_with_index do |talk_item, j|
                  talk_url = talk_item.css('.video-image').css('/a').first&.attr(:href)
                  talk_page = get_parsed_page("#{CONFREAKS_URL}#{talk_url}")

                  event = Parsers::Confreaks::EventParser.new(ruby_event).call
                  speakers = talk_page.css('.video-presenters').css('/a').map do |speaker_link|
                    Parsers::Confreaks::SpeakerParser.new(speaker_link).call
                  end
                  talk = Parsers::Confreaks::TalkParser.new(talk_item, talk_page).call
                  talk_repo.transaction do
                    # TODO: find or create event
                    e = event_repo.events.changeset(Changesets::Event::Create, event).commit
                    # TODO: find or create talk
                    t = talk_repo.talks.changeset(Changesets::Talk::Create, talk.merge(event_id: e&.id)).commit
                    speakers.map do |speaker_hash|
                      # TODO: find or create speaker
                      sp = speaker_repo.speakers.changeset(Changesets::Speaker::Create, speaker_hash).commit
                      talk_speaker_repo.create(speaker_id: sp.id, talk_id: t.id)
                    end
                  end
                end
              end
            end
          end

          private

          def select_ruby_events(html_page)
            event_nodes = html_page.css('.event-isotope')
            event_nodes.select do |event_node|
              conf_name = event_node.css('.event-img').text.strip.downcase
              BUZZWORDS.any? { |word| conf_name.include?(word) } && !event_without_videos?(event_node)
            end
          end

          def event_without_videos?(event_node)
            ['presentations available on youtube', '0 available presentations'].any? { |text| event_node.css('.text-muted').text.downcase.include?(text) }
          end

          def get_parsed_page(url)
            Nokogiri::HTML(open(url, read_timeout: 30, open_timeout: 30))
          end
        end
      end
    end
  end
end
