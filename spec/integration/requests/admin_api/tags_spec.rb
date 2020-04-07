# frozen_string_literal: true

RSpec.describe 'AdminApi: Tags', type: :request do
  let(:admin) { Factory[:user] }
  let(:jwt_token) { Hanami::Container['jwt'].encode(username: admin.username) }
  let(:auth_header) { { 'Authorization' => "Bearer #{jwt_token}" } }

  describe 'POST /admin_api/tags' do
    context 'with authentication' do
      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        let(:params) do
          {
            title: 'new tag'
          }
        end

        it 'returns 200' do
          post '/admin/tags', headers: headers, body: params.to_json

          expect(response_status).to eq 201
          expect(response_data.size).to be > 0
          expect(response_data).to match_json_schema('admin_api/tag')
        end
      end
    end
  end
end
