# frozen_string_literal: true

RSpec.describe AdminApi::Actions::Talks::Unpublished do
  subject { action.call(params) }

  let(:params) { {} }
  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, talks: service) }

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

    let(:talks) do
      3.times.map { Factory.structs[:talk] }
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
