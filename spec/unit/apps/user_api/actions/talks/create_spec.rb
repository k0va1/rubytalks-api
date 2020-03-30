# frozen_string_literal: true

RSpec.describe UserApi::Actions::Talks::Create do
  subject { action.call(params) }

  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, create: operation) }
  let(:operation) { instance_double(Domains::Talks::Operations::Create) }

  context 'when params are valid' do
    before do
      allow(operation).to receive(:call).and_return(Success(talk))
    end

    let(:speaking) { Factory[:speaking] }
    let(:talk_repo) { Repositories::Talk.new(Hanami::Container[:rom]) }
    let(:talk) { talk_repo.talks.combine(:speakers).by_pk(speaking.talk.id).one }

    let(:speakers) { [first_name: 'Alex', last_name: 'Koval'] }
    let(:params) do
      {
        title: 'title',
        description: 'description',
        link: 'https://google.com',
        talked_at: DateTime.now,
        speakers: speakers
      }
    end

    it 'invoke operation with params' do
      expect(operation).to receive(:call)
      subject
    end
  end
end
