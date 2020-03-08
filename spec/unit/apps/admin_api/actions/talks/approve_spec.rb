# frozen_string_literal: true

RSpec.describe AdminApi::Actions::Talks::Approve do
  subject { action.call(params) }

  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, approve: operation) }
  let(:operation) { instance_double(Domains::Talks::Operations::Approve) }

  context 'when operation is success' do
    let(:talk) { Factory.structs[:talk] }
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
