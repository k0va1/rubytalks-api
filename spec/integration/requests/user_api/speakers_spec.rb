# frozen_string_literal: true

RSpec.describe 'UserApi: Speakers', type: :request do
  describe 'GET /speakers/:id' do
    subject { get "/speakers/#{speaker.id}", headers: default_headers }

    context 'valid params' do
      let!(:speaker) do
        Hanami::Container['repositories.speaker'].create(Factory.structs[:approved_speaker])
      end

      it 'returns 200' do
        subject

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('user_api/speaker')
      end
    end
  end

  describe 'GET /speakers' do
    subject { get '/speakers', headers: default_headers }

    context 'valid params' do
      let!(:speaker) do
        Hanami::Container['repositories.speaker'].create(Factory.structs[:approved_speaker])
      end

      it 'returns 200' do
        subject

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('user_api/speakers')
      end
    end
  end
end
