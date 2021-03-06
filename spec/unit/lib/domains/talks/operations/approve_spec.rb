# frozen_string_literal: true

RSpec.describe Domains::Talks::Operations::Approve do
  subject { operation.call(id) }

  describe 'with mocks' do
    let(:operation) { described_class.new(talk_repo: talk_repo, speaker_repo: speaker_repo, event_repo: event_repo) }
    let(:talk) { Factory.structs[:talk] }
    let(:talk_repo) { instance_double(Repositories::Talk, transaction: nil, update: true) }
    let(:speaker_repo) { instance_double(Repositories::Speaker, update: true) }
    let(:event_repo) { instance_double(Repositories::Event, update: true) }
    let(:id) { 1 }

    context 'when every repo returns success value' do
      before do
        allow(talk_repo).to receive(:find_unapproved_by_id).and_return(talk)
      end

      it 'returns success' do
        expect(subject).to be_success
      end
    end

    context 'when talk is not found' do
      before do
        allow(talk_repo).to receive(:find_unapproved_by_id).and_raise(ROM::TupleCountMismatchError)
      end

      it 'returns failure' do
        expect(subject).to be_failure
      end
    end
  end
end
