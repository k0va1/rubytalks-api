# frozen_string_literal: true

RSpec.describe Parsers::Confreaks::TalkParser do
  subject { talk_parser.call }

  let(:event_body) { Nokogiri::HTML(File.open(File.join(fixtures_path, 'confreaks', 'event_body.txt'))) }
  let(:talk_parser) { described_class.new(event_body, talk_body) }

  context 'youtube talk' do
    let(:talk_body) { Nokogiri::HTML(File.open(File.join(fixtures_path, 'confreaks', 'yt_talk_body.txt'))) }

    it 'parses talk successfuly' do
      expect(subject[:title]).to eq('Ruby and Elixir')
      expect(subject[:description]).to eq('A narrative about choosing the right tool for the right job.')
      expect(subject[:talked_at]).to eq(DateTime.parse('January 7, 2015'))
      expect(subject[:link]).to eq('https://www.youtube.com/watch?v=t64A4p3pp80')
      expect(subject[:source]).to eq('youtube')
      expect(subject[:source_id]).to eq('t64A4p3pp80')
    end
  end

  context 'vimeo talk' do
    let(:talk_body) { Nokogiri::HTML(File.open(File.join(fixtures_path, 'confreaks', 'vimeo_talk_body.txt'))) }

    it 'parses talk successfuly' do
      expect(subject[:title]).to eq('Few Constraints More Concurrency')
      expect(subject[:description]).to eq("Traditional data structures like stacks and queues are strict - perhaps too strict. In this talk I will showcase some classical data structures and then provide alternative constraints that will allow our algorithms to achieve a greater level of concurrency. Examples will include a mix of Ruby and Postgres. Ryan Smith's educational background consists of Computer Science and Mathematics. He has contributed to projects like Queue Classic, ActiveMerchant, Gemcutter and others. These days he is crafting code on the API Team at Heroku") # rubocop:disable Layout/LineLength
      expect(subject[:talked_at]).to eq(DateTime.parse('January 7, 2015'))
      expect(subject[:link]).to eq('https://vimeo.com/25837628')
      expect(subject[:source]).to eq('vimeo')
      expect(subject[:source_id]).to eq('25837628')
    end
  end
end
