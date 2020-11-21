# frozen_string_literal: true

RSpec.describe Domains::Speakers::Operations::Approve do
  subject { operation.call(id) }

  describe 'with mocks' do
    let(:operation) { described_class.new(speaker_repo: speaker_repo) }
    let(:speaker_repo) { instance_double(Repositories::Speaker, update: true, find_by_id_with_talks: true) }
    let(:id) { 1 }

    it 'returns success' do
      expect(subject).to be_success
    end

    context 'when speaker is not found' do
      before do
        allow(speaker_repo).to receive(:update).and_raise(ROM::TupleCountMismatchError)
      end

      it 'returns failure' do
        expect(subject).to be_failure
      end
    end
  end
end
