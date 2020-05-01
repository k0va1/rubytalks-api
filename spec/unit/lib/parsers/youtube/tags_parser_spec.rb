# frozen_string_literal: true

RSpec.describe Parsers::Youtube::TagsParser do
  subject { tag_parser.call }

  let(:response) { File.open(File.join(fixtures_path, 'youtube', 'playlist_items.json')).read }
  let(:item) { Google::Apis::YoutubeV3::ListPlaylistItemsResponse.from_json(response) }
  let(:tag_parser) { described_class.new(item.items.first) }

  it 'parses tags successfuly' do
    expect(subject[0][:title]).to eq('bangbangcon')
    expect(subject[0][:slug]).to eq('bangbangcon')
    expect(subject[1][:title]).to eq('bangbangconwest')
    expect(subject[1][:slug]).to eq('bangbangconwest')
    expect(subject[2][:title]).to eq('bangbangconwest2020')
    expect(subject[2][:slug]).to eq('bangbangconwest2020')
  end
end
