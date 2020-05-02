# frozen_string_literal: true

RSpec.describe Util::Client::Youtube do
  let(:yt_service) { instance_double(Google::Apis::YoutubeV3::YouTubeService, 'key=': '123') }
  let(:client) { described_class.new(yt_service) }

  describe '#fetch_upload_playlist_id' do
    subject { client.fetch_upload_playlist_id(channel_id) }

    let(:channel_id) { 123 }

    context 'when exception raises' do
      before do
        allow(yt_service).to receive(:list_channels).and_raise(Google::Apis::Error, 'err')
      end

      it 'handles exception' do
        expect { subject }.to raise_error(Util::Client::YoutubeClientError)
      end
    end
  end
end
