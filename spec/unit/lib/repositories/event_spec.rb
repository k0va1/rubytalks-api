# frozen_string_literal: true

RSpec.describe Repositories::Event do
  subject { described_class.new(Hanami::Container[:rom]) }

  describe '.find_with_talks' do
    let(:event_id) { Factory[:approved_event].id }

    context 'when event exists' do
      it 'returns event by id' do
        result = subject.find_with_talks(id: event_id)

        expect(result.id).to eq(event_id)
      end
    end

    context 'when event does not exist' do
      let(:event_id) { -1 }

      it 'raises an error' do
        expect { subject.find_with_talks(id: event_id) }.to raise_error(ROM::TupleCountMismatchError)
      end
    end
  end
end
