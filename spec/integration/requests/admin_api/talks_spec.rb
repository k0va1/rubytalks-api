# frozen_string_literal: true

RSpec.describe 'AdminApi: Talks', type: :request do
  let(:admin) { Factory[:user] }
  let(:jwt_token) { Hanami::Container['jwt'].encode(username: admin.username) }
  let(:auth_header) { { 'Authorization' => "Bearer #{jwt_token}" } }

  describe 'GET /admin_api/talks/unpublished' do
    context 'with authentication' do
      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        before do
          talk = Factory.structs[:unpublished_talk]
          Hanami::Container['repositories.talk'].create(talk)
        end

        it 'returns 200' do
          get '/admin/talks/unpublished', headers: headers

          expect(response_status).to eq 200
          expect(response_data.size).to be > 0
          expect(response_data).to match_json_schema('admin_api/talks')
        end
      end
    end
  end

  describe 'POST /admin_api/talks/:id/approve' do
    context 'with authentication' do
      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        let(:talk) do
          talk = Factory.structs[:unpublished_talk]
          Hanami::Container['repositories.talk'].create(talk)
        end

        it 'returns 200' do
          post "/admin/talks/#{talk.id}/approve", headers: headers

          expect(response_status).to eq 200
          expect(response_data).to match_json_schema('admin_api/talk')
        end
      end
    end
  end

  describe 'POST /admin_api/talks/:id/decline' do
    context 'with authentication' do
      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        let(:talk) do
          talk = Factory.structs[:approved_talk]
          Hanami::Container['repositories.talk'].create(talk)
        end

        it 'returns 200' do
          post "/admin/talks/#{talk.id}/decline", headers: headers

          expect(response_status).to eq 200
          expect(response_data).to match_json_schema('admin_api/talk')
        end
      end
    end
  end

  describe 'PATCH /admin_api/talks/:id' do
    context 'with authentication' do
      let(:headers) { default_headers.merge(auth_header) }

      context 'valid params' do
        let(:new_title) { 'new title' }
        let(:talk) do
          talk = Factory.structs[:approved_talk]
          Hanami::Container['repositories.talk'].create(talk)
        end

        let(:params) do
          {
            title: new_title
          }
        end

        it 'returns 200' do
          patch "/admin/talks/#{talk.id}", body: params.to_json, headers: headers

          expect(response_status).to eq 200
          expect(response_data).to match_json_schema('admin_api/talk')
          expect(response_data['title']).to eq new_title
        end
      end
    end
  end
end
