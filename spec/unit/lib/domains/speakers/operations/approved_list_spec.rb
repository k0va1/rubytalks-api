# frozen_string_literal: true

RSpec.describe Domains::Speakers::Operations::ApprovedList do
  subject { operation.call({}) }

  let(:operation) { described_class.new(speaker_repo: speaker_repo) }
  let(:speaker_repo) { instance_double(Repositories::Speaker, all_approved: speakers) }
  let(:speakers) do
    3.times.map { Factory.structs[:speaker] }
  end

  context 'when speakers exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'when there are no speakers' do
    let(:speaker_repo) { instance_double(Repositories::Speaker, all_approved: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end
end
