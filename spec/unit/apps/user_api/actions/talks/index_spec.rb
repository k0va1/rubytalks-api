# frozen_string_literal: true

RSpec.describe UserApi::Actions::Talks::Index do
  subject { action.call(params) }

  let(:params) { { page: 1 } }
  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, talks: service) }

  context 'when operation is success' do
    let(:service) { instance_double(UserApi::Services::Talks, talk_list: Success(result)) }
    let(:result) { Entities::PaginatedCollection.new(data: talks, meta: {}) }
    let(:talk_repo) { Repositories::Talk.new(Hanami::Container[:rom]) }
    let(:speakings) { 3.times.map { Factory[:speaking] } }
    let(:talks) do
      talk_repo.talks.combine(:speakers, :tags, :event).where(id: speakings.map(&:talk_id)).to_a
    end

    it { expect(subject[0]).to eq(200) }
  end
end
