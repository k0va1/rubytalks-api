# frozen_string_literal: true

require 'google/apis/youtube_v3'

module Util
  module Client
    class YoutubeClientError < StandardError; end

    class Youtube
      MAX_RESULTS = 50

      def initialize(client = Google::Apis::YoutubeV3::YouTubeService.new)
        @client = client
        @client.key = ENV.fetch('YOUTUBE_API_KEY')
      end

      def fetch_all_playlists(channel_id)
        paginated_request do |next_page_token|
          client.list_playlists(
            'snippet',
            channel_id: channel_id,
            max_results: MAX_RESULTS,
            page_token: next_page_token
          )
        end
      end

      def fetch_all_playlist_items(playlist_id)
        paginated_request do |next_page_token|
          client.list_playlist_items(
            'snippet,contentDetails',
            playlist_id: playlist_id,
            max_results: MAX_RESULTS,
            page_token: next_page_token
          )
        end
      end

      def fetch_upload_playlist_id(channel_id)
        response = handle_exception { client.list_channels('contentDetails', id: channel_id) }
        response.items.first.content_details.related_playlists.uploads
      end

      private

      def paginated_request
        next_page_token = ''
        items = []

        handle_exception do
          until next_page_token.nil?
            response = yield(next_page_token)
            items += response.items
            next_page_token = response.next_page_token
          end
        end

        items
      end

      def handle_exception
        yield
      rescue Google::Apis::Error => e
        raise Util::Client::YoutubeClientError, e
      end

      attr_reader :client
    end
  end
end
