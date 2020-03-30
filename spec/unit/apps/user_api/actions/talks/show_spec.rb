# frozen_string_literal: true

RSpec.describe UserApi::Actions::Talks::Show do
  subject { action.call(params) }

  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, find_approved: operation) }

  context 'when operation is success' do
    let(:speaking) { Factory[:speaking] }
    let(:talk_repo) { Repositories::Talk.new(Hanami::Container[:rom]) }
    let(:talk) { talk_repo.talks.combine(:speakers).by_pk(speaking.talk.id).one }
    let(:operation) { ->(*) { Success(talk) } }
    let(:params) { { id: talk.id } }

    it { expect(subject[0]).to eq(200) }
  end

  context 'when operation is failure' do
    let(:params) { { id: -100 } }
    let(:operation) { ->(*) { Failure(ROM::TupleCountMismatchError) } }

    it 'redirects to 404' do
      expect(subject[0]).to eq(404)
    end
  end
end
