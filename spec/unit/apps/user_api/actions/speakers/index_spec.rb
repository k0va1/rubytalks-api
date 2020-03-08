# frozen_string_literal: true

RSpec.describe UserApi::Actions::Speakers::Index do
  # subject { action.call(params) }
  #
  # let(:params) { {} }
  # let(:action) { described_class.new(operation: operation) }
  #
  # context 'when operation is success' do
  #   let(:speakers) { Fabricate.build_times(3, :speaker) }
  #   let(:operation) { ->(*) { Success(speakers) } }
  #
  #   it { expect(subject.first).to eq(200) }
  #
  #   it 'exposes speakers' do
  #     subject
  #     expect(action.speakers).to eq(speakers)
  #   end
  # end
  #
  # context 'when operation is failure' do
  #   let(:operation) { ->(*) { Failure() } }
  #
  #   it { expect(subject.first).to eq(400) }
  # end
  #
  # context 'with real data' do
  #   let!(:speakers) { Fabricate.times(3, :approved_speaker) }
  #   let(:action) { described_class.new }
  #
  #   it { expect(subject.first).to eq(200) }
  #
  #   it 'exposes speakers' do
  #     subject
  #     expect(action.speakers).to match_array(speakers)
  #   end
  # end
end
