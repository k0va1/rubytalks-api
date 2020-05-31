# frozen_string_literal: true

RSpec.describe UserApi::Actions::Events::Show do
  subject { action.call(params) }

  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, find_approved: operation) }

  # TODO: don't know to create structs with custom nested objects
  xcontext 'when operation is success' do
    let(:event) { Factory.structs[:event] }
    let(:operation) { ->(*) { Success(event) } }
    let(:params) { { id: event.id } }

    it { expect(subject[0]).to eq(200) }
  end

  context 'when operation is failure' do
    let(:params) { { id: -100 } }
    let(:operation) { ->(*) { Failure(:not_found) } }

    it 'returns 404' do
      expect(subject[0]).to eq(404)
    end
  end
end
