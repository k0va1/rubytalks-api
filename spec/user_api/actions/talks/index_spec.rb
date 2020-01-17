# frozen_string_literal: true

RSpec.describe UserApi::Actions::Talks::Index do
  subject { action.call(params) }

  let(:params) { { page: 1 } }
  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, talks: service) }

  context 'when operation is success' do
    let(:service) { instance_double(UserApi::Services::Talks, approved_talks_list: Success(result)) }
    let(:result) { Entities::PaginatedCollection.new(data: talks, meta: {}) }
    let(:talks) { 3.times.map { Factory.structs[:talk] } }

    it { expect(subject.status).to eq(200) }
  end
end
