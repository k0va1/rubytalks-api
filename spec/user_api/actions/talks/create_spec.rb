# frozen_string_literal: true

RSpec.describe UserApi::Actions::Talks::Create do
  subject { action.call(params) }

  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, create: operation) }
  let(:operation) { instance_double(Domains::Talks::Operations::Create) }

  context 'when params are valid' do
    before do
      allow(operation).to receive(:call).and_return(Success(Factory.structs[:talk]))
    end

    let(:params) { { title: 'title', description: 'description', link: 'https://google.com', talked_at: DateTime.now } }

    it 'invoke operation with params' do
      expect(operation).to receive(:call)
      subject
    end
  end
end
