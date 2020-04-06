# frozen_string_literal: true

RSpec.describe AdminApi::Actions::Talks::Approve do
  subject { action.call(params) }

  let(:action) do
    described_class.new(
      configuration: Hanami::Controller::Configuration.new,
      approve: operation,
      authenticator: authenticator
    )
  end
  let(:operation) { instance_double(Domains::Talks::Operations::Approve) }
  let(:authenticator) { instance_double(AdminApi::Services::Authenticator, call: true) }

  # TODO: use structs instead of DB
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
