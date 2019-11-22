# # frozen_string_literal: true

# RSpec.describe Admin::Controllers::Talks::Unpublished do
#   subject { action.call(params) }

#   let(:params) { {} }
#   let(:action) { described_class.new(operation: operation) }

#   context 'when operation is success' do
#     let(:talks) { Fabricate.build_times(3, :talk) } # unapproved
#     let(:service) { instance_double(AdminApi::Services::Talks) }

#     let(:result) do
#       Entities::PaginatedCollection.new(
#         data: talks,
#         meta: {}
#       )
#     end

#     before do
#       allow(service).to receive(:unpublished).and_return(Success(result))
#     end

#     it { expect(subject.first).to eq(200) }

#     it 'exposes talks' do
#       subject
#       expect(action.talks).to eq(talks)
#     end
#   end

#   context 'when operation is failure' do
#     let(:talks) { Fabricate.build_times(3, :talk) } # unapproved
#     let(:operation) { ->(*) { Failure(result: talks) } }

#     it { expect(subject.first).to eq(400) }
#   end

#   context 'with real data' do
#     let!(:talks) { Fabricate.times(3, :talk) }
#     let(:action) { described_class.new }

#     it { expect(subject.first).to eq(200) }

#     it 'exposes talks' do
#       subject
#       expect(action.talks).to match_array(talks)
#     end
#   end
# end
