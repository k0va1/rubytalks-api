# frozen_string_literal: true

RSpec.describe AdminApi::Actions::Talks::Unpublished do
  subject { action.call(params) }

  let(:params) { {} }
  let(:action) do
    described_class.new(
      configuration: Hanami::Controller::Configuration.new,
      talks: service,
      authenticator: authenticator
    )
  end
  let(:authenticator) { instance_double(AdminApi::Services::Authenticator, call: true) }

  context 'when operation is success' do
    let(:service) { instance_double(AdminApi::Services::Talks) }

    let(:result) do
      Entities::PaginatedCollection.new(
        data: talks,
        meta: {}
      )
    end

    before do
      allow(service).to receive(:unpublished).and_return(Success(result))
    end

    let(:talk_repo) { Repositories::Talk.new(Hanami::Container[:rom]) }
    let(:speakings) { 3.times.map { Factory[:speaking] } }
    let(:talks) do
      talk_repo.talks.combine(:speakers).where(id: speakings.map(&:talk_id)).to_a
    end

    it { expect(subject[0]).to eq(200) }
  end

  # context 'when operation is failure' do
  #   let(:operation) { ->(*) { Failure(result: talks) } }
  #   let(:talks) do
  #     3.times.map { Factory.structs[:talk] }
  #   end

  #   it { expect(subject.status).to eq(400) }
  # end
end
