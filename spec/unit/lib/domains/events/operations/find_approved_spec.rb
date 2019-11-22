# frozen_string_literal: true

RSpec.describe Domains::Events::Operations::FindApproved do
  subject { operation.call(id: 1) }

  let(:operation) { described_class.new(event_repo: event_repo) }
  let(:event_repo) { instance_double(Repositories::Event, find_with_talks: Factory.structs[:event]) }

  context 'when event exists' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(ROM::Struct::Event) }
  end

  context 'when event does not exist' do
    let(:event_repo) { instance_double(Repositories::Event) }

    before { allow(event_repo).to receive(:find_with_talks).and_raise(ROM::TupleCountMismatchError) }

    it { expect(subject).to be_failure }
  end
end
