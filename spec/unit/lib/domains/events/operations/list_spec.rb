# frozen_string_literal: true

RSpec.describe Domains::Events::Operations::List do
  subject { operation.call({}) }

  let(:operation) { described_class.new(event_repo: event_repo) }
  let(:event_repo) { instance_double(Repositories::Event, all: events) }

  let(:events) do
    3.times.map { Factory.structs[:event] }
  end

  context 'when events exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'when there are no events' do
    let(:event_repo) { instance_double(Repositories::Event, all: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end
end
