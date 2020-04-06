# frozen_string_literal: true

RSpec.describe 'AdminApi: Sessions', type: :request do
  describe 'POST /admin/login' do
    let(:user) { Factory[:user] }

    context 'valid params' do
      let(:params) do
        {
          username: user.username,
          password: '123123123'
        }
      end

      it 'returns 201' do
        post '/admin/login', headers: default_headers, body: params.to_json

        expect(response_status).to eq 201
        expect(response_data.size).to be > 0
        expect(response_data).to match_json_schema('admin_api/session')
      end
    end

    # TODO: restore after errors mapper implementation
    xcontext 'with invalid password' do
      let(:params) do
        {
          username: user.username,
          password: 'wtf?'
        }
      end

      it 'returns 201' do
        post '/admin/login', headers: default_headers, body: params.to_json

        expect(response_status).to eq 401
      end
    end
  end
end
