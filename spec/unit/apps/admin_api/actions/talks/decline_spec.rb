# frozen_string_literal: true

RSpec.describe AdminApi::Actions::Talks::Decline do
  subject { action.call(params) }

  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, decline: operation) }
  let(:operation) { instance_double(Domains::Talks::Operations::Decline) }

  context 'when operation is success' do
    let(:speaking) { Factory[:speaking] }
    let(:talk_repo) { Repositories::Talk.new(Hanami::Container[:rom]) }
    let(:talk) { talk_repo.talks.combine(:speakers).by_pk(speaking.talk.id).one }
    let(:operation) { ->(*) { Success(talk) } }
    let(:params) { { id: talk.id } }

    it { expect(subject[0]).to eq(200) }
  end

  context 'when operation is not success' do
    let(:params) { { id: -100 } }
    let(:operation) { ->(*) { Failure(ROM::TupleCountMismatchError) } }

    it { expect(subject[0]).to eq(404) }
  end
end
