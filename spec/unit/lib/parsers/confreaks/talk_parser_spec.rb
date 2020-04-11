# frozen_string_literal: true

RSpec.describe Parsers::Confreaks::TalkParser do
  subject { talk_parser.call }

  let(:event_body) { Nokogiri::HTML(File.open(File.join(fixtures_path, 'confreaks', 'event_body.txt'))) }
  let(:talk_body) { Nokogiri::HTML(File.open(File.join(fixtures_path, 'confreaks', 'yt_talk_body.txt'))) }

  let(:talk_parser) { described_class.new(event_body, talk_body) }

  it 'parses talk successfuly' do
    expect(subject[:title]).to eq('Ruby and Elixir')
    expect(subject[:description]).to eq('A narrative about choosing the right tool for the right job.')
    expect(subject[:talked_at]).to eq(DateTime.parse('January 7, 2015'))
    expect(subject[:link]).to eq('https://www.youtube.com/watch?v=t64A4p3pp80')
  end
end
