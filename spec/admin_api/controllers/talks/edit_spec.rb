# # frozen_string_literal: true

# RSpec.describe Admin::Controllers::Talks::Edit do
#   subject { action.call(params) }

#   let(:action) { described_class.new(operation: operation) }

#   context 'when operation is success' do
#     let(:talk) { Talk.new(id: 1) }
#     let(:operation) { ->(*) { Success(talk) } }
#     let(:params) { { id: talk.id } }

#     it { expect(subject.first).to eq(200) }
#   end

#   context 'when operation is not success' do
#     let(:params) { { id: -100 } }
#     let(:operation) { ->(*) { Failure(nil) } }

#     it { expect(subject.first).to eq(404) }
#   end

#   context 'with real data' do
#     context 'when talk exists' do
#       let(:talk) { Fabricate.create(:talk_with_speaker_and_event) }
#       let(:action) { described_class.new }
#       let(:params) { { id: talk.id } }

#       it { expect(subject.first).to eq(200) }
#       it 'renders edit page' do
#         subject
#         expect(action.exposures[:talk]).to eq(talk)
#       end
#     end

#     context 'when talk does not exist' do
#       let(:action) { described_class.new }
#       let(:params) { { id: 0 } }

#       it { expect(subject.first).to eq(404) }
#     end
#   end
# end
