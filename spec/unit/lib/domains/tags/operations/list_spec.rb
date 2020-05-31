# frozen_string_literal: true

RSpec.describe Domains::Tags::Operations::List do
  subject { operation.call(input) }

  let(:approved_tags) { 3.times.map { Factory.structs[:tag, state: 'approved'] } }
  let(:tag_query) { instance_double(Domains::Tags::Queries::Tag, all: approved_tags) }
  let(:operation) { described_class.new(tag_query: tag_query) }
  let(:input) { {} }

  context 'tags exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'there are no tags' do
    let(:tag_query) { instance_double(Domains::Tags::Queries::Tag, all: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end
end
