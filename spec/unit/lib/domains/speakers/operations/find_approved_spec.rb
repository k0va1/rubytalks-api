# frozen_string_literal: true

RSpec.describe Domains::Speakers::Operations::FindApproved do
  subject { operation.call(id: 1) }

  let(:operation) { described_class.new(speaker_repo: speaker_repo) }
  let(:speaker_repo) { instance_double(Repositories::Speaker, find_with_talks: Factory.structs[:speaker]) }

  context 'when speaker exists' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(ROM::Struct::Speaker) }
  end

  context 'when speaker does not exist' do
    let(:speaker_repo) { instance_double(Repositories::Speaker) }

    before { allow(speaker_repo).to receive(:find_with_talks).and_raise(ROM::TupleCountMismatchError) }

    it { expect(subject).to be_failure }
  end
end
