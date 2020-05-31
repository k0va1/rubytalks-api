# frozen_string_literal: true

RSpec.describe Domains::Speakers::Operations::List do
  subject { operation.call({}) }

  let(:operation) { described_class.new(speaker_query: speaker_query) }
  let(:speaker_query) { instance_double(Domains::Speakers::Queries::Speaker, all: speakers) }
  let(:speakers) do
    3.times.map { Factory.structs[:speaker] }
  end

  context 'when speakers exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'when there are no speakers' do
    let(:speaker_query) { instance_double(Domains::Speakers::Queries::Speaker, all: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end
end
