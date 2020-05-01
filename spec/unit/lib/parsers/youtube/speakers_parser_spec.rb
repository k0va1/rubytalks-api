# frozen_string_literal: true

RSpec.describe Parsers::Youtube::SpeakersParser do
  subject { speaker_parser.call }

  let(:response) { File.open(File.join(fixtures_path, 'youtube', 'playlist_items.json')).read }
  let(:item) { Google::Apis::YoutubeV3::ListPlaylistItemsResponse.from_json(response) }
  let(:speaker_parser) { described_class.new(item.items[1]) }
  let(:nlp_client) { instance_double(Util::Client::Nlp, fetch_people: ['isis agova lovecruft']) }

  before do
    Hanami::Container.stub('util.client.nlp', nlp_client)
  end

  it 'parses speaker successfuly' do
    expect(subject[0][:first_name]).to eq('Isis')
    expect(subject[0][:middle_name]).to eq('Agova')
    expect(subject[0][:last_name]).to eq('Lovecruft')
    expect(subject[0][:slug]).to eq('isis-agova-lovecruft')
  end

  context 'without speakers' do
    let(:nlp_client) { instance_double(Util::Client::Nlp, fetch_people: []) }
    let(:speaker_parser) { described_class.new(item.items[28]) }

    it 'parses speaker successfuly' do
      expect(subject).to eq([])
    end
  end

  context 'with several speakers' do
    let(:nlp_client) { instance_double(Util::Client::Nlp, fetch_people: ['isis agova lovecruft', 'Alex A. Koval']) }

    it 'parses speaker successfuly' do
      expect(subject[0][:first_name]).to eq('Isis')
      expect(subject[0][:middle_name]).to eq('Agova')
      expect(subject[0][:last_name]).to eq('Lovecruft')
      expect(subject[0][:slug]).to eq('isis-agova-lovecruft')

      expect(subject[1][:first_name]).to eq('Alex')
      expect(subject[1][:middle_name]).to eq('A.')
      expect(subject[1][:last_name]).to eq('Koval')
      expect(subject[1][:slug]).to eq('alex-a-koval')
    end
  end
end
