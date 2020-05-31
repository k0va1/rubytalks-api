# frozen_string_literal: true

RSpec.describe Domains::Talks::Operations::List do
  subject { operation.call({}) }

  let(:operation) { described_class.new(talk_query: talk_query) }
  let(:talk_query) { instance_double(Domains::Talks::Queries::Talk, all: talks) }
  let(:talks) do
    3.times.map { Factory.structs[:talk] }
  end

  context 'talks exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'there are no talks' do
    let(:talk_query) { instance_double(Domains::Talks::Queries::Talk, all: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end
end
