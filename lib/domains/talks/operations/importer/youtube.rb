# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      module Importer
        class Youtube
          include BaseImporter
          include Operation
          include Import[
            talk_repo: 'repositories.talk',
            speaker_repo: 'repositories.speaker',
            event_repo: 'repositories.event',
            speaking_repo: 'repositories.speaking',
            tag_repo: 'repositories.tag',
            tagging_repo: 'repositories.tagging',
            yt_parser: 'parsers.youtube.parser',
            yt_client: 'util.client.youtube'
          ]

          CONFREAKS_CHANNEL_ID = 'UCWnPjmqvljcafA0z2U1fwKQ'

          def call
            Try do
              process_playlists
              process_all_videos
              Success('Import successfully passed')
            end
          end

          private

          def process_playlists # rubocop:disable Metrics/AbcSize
            playlists_to_process = yt_client.fetch_all_playlists(CONFREAKS_CHANNEL_ID).select do |item|
              buzzwords.any? { |word| item.snippet.title.strip.downcase.include?(word) }
            end

            playlists_to_process.each do |playlist|
              yt_client.fetch_all_playlist_items(playlist.id).each do |item|
                yt_parser.call(item, playlist)
                persist_items
              end
            end
          end

          # from `Uploads` playlist
          def process_all_videos # rubocop:disable Metrics/AbcSize
            playlist_id = yt_client.fetch_upload_playlist_id(CONFREAKS_CHANNEL_ID)

            yt_client.fetch_all_playlist_items(playlist_id).each do |item|
              next unless buzzwords.any? { |word| item.snippet.title.strip.downcase.include?(word) }

              yt_parser.call(item)
              persist_items
            end
          end

          def persist_items # rubocop:disable Metrics/AbcSize
            return if talk_exists?(yt_parser.talk[:source_id])

            talk_repo.transaction do
              event = event_repo.find_or_create(yt_parser.event) if yt_parser.event
              talk = talk_repo.find_or_create(yt_parser.talk.merge(event_id: event&.id))

              yt_parser.speakers.each do |speaker|
                speaker = speaker_repo.find_or_create(speaker)
                speaking_repo.find_or_create(speaker_id: speaker.id, talk_id: talk.id)
              end

              yt_parser.tags.each do |tag|
                tag = tag_repo.find_or_create(tag)
                tagging_repo.find_or_create(tag_id: tag.id, talk_id: talk.id)
              end
            end
          end

          def talk_exists?(source_id)
            talk_repo.root.exist?(source_id: source_id)
          end
        end
      end
    end
  end
end
