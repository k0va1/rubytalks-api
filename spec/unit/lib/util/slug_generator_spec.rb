# frozen_string_literal: true

RSpec.describe Util::SlugGenerator do
  subject { slug_generator.call(args) }

  let(:slug_generator) { Hanami::Container['util.slug_generator'] }

  context 'when args is nil' do
    let(:args) { nil }

    it 'returns empty string' do
      is_expected.to eq('')
    end
  end

  context 'when args is empty array' do
    let(:args) { [] }

    it 'returns empty string' do
      is_expected.to eq('')
    end
  end

  context 'when args is has one element' do
    let(:args) { 'hElLo' }

    it 'returns downcased string' do
      is_expected.to eq('hello')
    end

    context 'with unsupported symbols' do
      let(:args) { 'Alex A. Koval' }

      it 'removes unsupported symbols' do
        is_expected.to eq('alex-a-koval')
      end
    end

    context 'when element has more than one word' do
      let(:args) { 'hello world' }

      it 'returns downcased string' do
        is_expected.to eq('hello-world')
      end
    end
  end

  context 'when args many elements' do
    let(:args) { %w[hElLo world agAin] }

    it 'returns downcased string separated by dashes' do
      is_expected.to eq('hello-world-again')
    end
  end
end
