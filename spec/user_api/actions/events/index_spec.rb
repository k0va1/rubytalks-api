# frozen_string_literal: true

RSpec.describe UserApi::Actions::Events::Index do
  subject { action.call(params) }

  let(:params) { {} }
  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, events: service) }

  context 'when operation is success' do
    let(:service) { instance_double(UserApi::Services::Events, approved_events_list: Success(result)) }
    let(:result) { Entities::PaginatedCollection.new(data: events, meta: {}) }
    let(:events) { 3.times.map { Factory.structs[:event] } }

    it { expect(subject.status).to eq(200) }
  end
end
