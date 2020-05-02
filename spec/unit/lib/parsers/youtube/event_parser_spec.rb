# frozen_string_literal: true

RSpec.describe Parsers::Youtube::EventParser do
  subject { event_parser.call }

  let(:response) { File.open(File.join(fixtures_path, 'youtube', 'playlist_items.json')).read }
  let(:item) { Google::Apis::YoutubeV3::ListPlaylistItemsResponse.from_json(response).items[1] }
  let(:event_parser) { described_class.new(item, playlist) }

  context 'without playlist' do
    let(:playlist) { nil }

    it 'parses speaker successfuly' do
      expect(subject[:name]).to eq('!!Con West 2020')
      expect(subject[:slug]).to eq('con-west-2020')
    end
  end

  context 'with playlist' do
    let(:playlist_response) { File.open(File.join(fixtures_path, 'youtube', 'playlist.json')).read }
    let(:playlist) { Google::Apis::YoutubeV3::ListPlaylistResponse.from_json(playlist_response).items[0] }

    it 'parses speaker successfuly' do
      expect(subject[:name]).to eq('DevOpsDays NYC 2020')
      expect(subject[:slug]).to eq('devopsdays-nyc-2020')
    end
  end
end
