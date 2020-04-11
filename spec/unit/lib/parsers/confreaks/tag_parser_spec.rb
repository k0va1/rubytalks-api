# frozen_string_literal: true

RSpec.describe Parsers::Confreaks::TagParser do
  subject { tag_parser.call }

  let(:talk_body) { Nokogiri::HTML(File.open(File.join(fixtures_path, 'confreaks', 'yt_talk_body.txt'))) }
  let(:tag_element) { talk_body.css('.video-bottom-info-middle').css('.tag').first }

  let(:tag_parser) { described_class.new(tag_element) }

  it 'parses tag successfuly' do
    expect(subject[:title]).to eq('elixir')
    expect(subject[:slug]).to eq('elixir')
  end
end
