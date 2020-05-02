# frozen_string_literal: true

RSpec.describe Parsers::Youtube::TalkParser do
  subject { talk_parser.call }

  let(:response) { File.open(File.join(fixtures_path, 'youtube', 'playlist_items.json')).read }
  let(:item) { Google::Apis::YoutubeV3::ListPlaylistItemsResponse.from_json(response) }
  let(:talk_parser) { described_class.new(item.items.first) }

  it 'parses talk successfuly' do
    expect(subject[:title]).to eq('!!Con West 2020 - Opening remarks')
    expect(subject[:description]).to eq('Why are we having this conference?  And especially in these particularly dark days, why are we having a conference at all?  Some words about our code of conduct, and some words from Sohum Banerjea, who is a graduate student worker who was fired from UC Santa Cruz just a few hours before we started setup on Friday -- and, finally some answers as to why we find !!Con so important.') # rubocop:disable Layout/LineLength
    expect(subject[:link]).to eq('https://www.youtube.com/watch?v=kzIeEo6JM1w')
    expect(subject[:source_id]).to eq('kzIeEo6JM1w')
    expect(subject[:source]).to eq('youtube')
  end
end
