# frozen_string_literal: true

RSpec.describe 'AdminApi: Events', type: :request do
  let(:admin) { Factory[:user] }
  let(:jwt_token) { Hanami::Container['jwt'].encode(username: admin.username) }
  let(:auth_header) { { 'Authorization' => "Bearer #{jwt_token}" } }

  describe 'PATCH /admin_api/events/:id' do
    context 'with authentication' do
      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        let(:name) { 'Whatever' }
        let(:event) do
          Hanami::Container['repositories.event'].create(Factory.structs[:event])
        end

        let(:params) do
          {
            name: name
          }
        end

        it 'returns 200' do
          patch "/admin/events/#{event.id}", body: params.to_json, headers: headers

          expect(response_status).to eq 200
          expect(response_data).to match_json_schema('admin_api/event')
          expect(response_data['name']).to eq name
        end
      end
    end
  end

  describe 'GET /admin_api/events' do
    context 'with authentication' do
      let!(:event1) { Factory[:event, state: 'unpublished'] }
      let!(:event2) { Factory[:event, state: 'approved'] }
      let!(:event3) { Factory[:event, state: 'declined'] }

      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        describe 'unpublished' do
          it 'returns 200' do
            get '/admin/events?state=unpublished', headers: headers

            expect(response_status).to eq 200
            expect(response_data.size).to be > 0
            expect(response_data.first['state']).to eq('unpublished')
            expect(response_data).to match_json_schema('admin_api/events')
          end
        end

        describe 'approved' do
          it 'returns 200' do
            get '/admin/events?state=approved', headers: headers

            expect(response_status).to eq 200
            expect(response_data.size).to be > 0
            expect(response_data.first['state']).to eq('approved')
            expect(response_data).to match_json_schema('admin_api/events')
          end
        end

        describe 'declined' do
          it 'returns 200' do
            get '/admin/events?state=declined', headers: headers

            expect(response_status).to eq 200
            expect(response_data.size).to be > 0
            expect(response_data.first['state']).to eq('declined')
            expect(response_data).to match_json_schema('admin_api/events')
          end
        end
      end
    end
  end
end
