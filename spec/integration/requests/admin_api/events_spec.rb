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
end
