# frozen_string_literal: true

RSpec.describe 'UserApi: Talks', type: :request do
  describe 'GET /talks/:id' do
    context 'valid params' do
      let(:talk) do
        talk = Factory.structs[:approved_talk]
        Hanami::Container['repositories.talk'].create(talk)
      end

      it 'returns 200' do
        get "/talks/#{talk.id}", headers: default_headers

        expect(response_status).to eq(200)
        expect(response_data).to match_json_schema('user_api/talk')
      end
    end
  end

  describe 'GET /talks' do
    context 'valid params' do
      before do
        talk = Factory.structs[:approved_talk]
        Hanami::Container['repositories.talk'].create(talk)
      end

      it 'returns 200' do
        get '/talks', headers: default_headers

        expect(response_status).to eq 200
        expect(response_data.size).to be > 0
        expect(response_data).to match_json_schema('user_api/talks')
      end
    end
  end
end
