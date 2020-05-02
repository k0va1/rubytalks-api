# frozen_string_literal: true

RSpec.describe Parsers::Youtube::Parser do
  subject { parser.call(item.items[1]) }

  let(:response) { File.open(File.join(fixtures_path, 'youtube', 'playlist_items.json')).read }
  let(:item) { Google::Apis::YoutubeV3::ListPlaylistItemsResponse.from_json(response) }
  let(:parser) { described_class.new }

  let(:nlp_client) { instance_double(Util::Client::Nlp, fetch_people: ['isis agova lovecruft']) }

  before do
    Hanami::Container.stub('util.client.nlp', nlp_client)
  end

  it 'parses all nested entities' do
    subject

    expect(parser.talk).not_to be_empty
    expect(parser.speakers).not_to be_empty
    expect(parser.tags).not_to be_empty
    expect(parser.event).not_to be_empty
  end
end
