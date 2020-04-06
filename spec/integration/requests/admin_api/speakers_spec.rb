# frozen_string_literal: true

RSpec.describe 'AdminApi: Speakers', type: :request do
  let(:admin) { Factory[:user] }
  let(:jwt_token) { Hanami::Container['jwt'].encode(username: admin.username) }
  let(:auth_header) { { 'Authorization' => "Bearer #{jwt_token}" } }

  describe 'PATCH /admin_api/speakers/:id' do
    context 'with authentication' do
      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        let(:first_name) { 'Whatever' }
        let(:speaker) do
          Hanami::Container['repositories.speaker'].create(Factory.structs[:speaker])
        end

        let(:params) do
          {
            first_name: first_name
          }
        end

        it 'returns 200' do
          patch "/admin/speakers/#{speaker.id}", body: params.to_json, headers: headers

          expect(response_status).to eq 200
          expect(response_data).to match_json_schema('admin_api/speaker')
          expect(response_data['first_name']).to eq first_name
        end
      end
    end
  end
end
