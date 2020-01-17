# frozen_string_literal: true

RSpec.describe 'UserApi: Events', type: :request do
  describe 'GET /events/:id' do
    subject { get "/events/#{event.id}", headers: default_headers }

    context 'valid params' do
      let!(:event) do
        Hanami::Container['repositories.event'].create(Factory.structs[:approved_event])
      end

      it 'returns 200' do
        subject

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('user_api/event')
      end
    end
  end

  describe 'GET /events' do
    subject { get '/events', headers: default_headers }

    context 'valid params' do
      let!(:event) do
        Hanami::Container['repositories.event'].create(Factory.structs[:approved_event])
      end

      it 'returns 200' do
        subject

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('user_api/events')
      end
    end
  end
end
