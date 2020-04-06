# frozen_string_literal: true

describe ApiAuthenticationStrategy do
  let(:user) { Factory[:user] }
  let(:jwt) { Hanami::Container['jwt'].encode(username: user.username) }

  describe '#valid?' do
    subject { obj.valid? }

    before { allow(obj).to receive(:env).and_return(env) }

    let(:obj) { described_class.new(nil) }

    context 'with valid header' do
      let(:env) { { 'HTTP_AUTHORIZATION' => "Bearer #{jwt}" } }

      it { is_expected.to eq(true) }
    end

    context 'without header' do
      let(:env) { {} }

      it { is_expected.to eq(false) }
    end

    context 'with invalid header' do
      let(:env) { { 'HTTP_AUTHORIZATION' => nil } }

      it { is_expected.to eq(false) }
    end
  end

  describe '#authenticate!' do
    subject { obj.authenticate! }

    before { allow(obj).to receive(:env).and_return(env) }

    let(:obj) { described_class.new(nil) }

    context 'with valid jwt' do
      let(:env) { { 'HTTP_AUTHORIZATION' => "Bearer #{jwt}" } }

      it { is_expected.to eq(:success) }
    end

    context 'with invalid jwt' do
      let(:env) { { 'HTTP_AUTHORIZATION' => 'Bearer invalid_jwt1232131' } }

      it { is_expected.to eq(:failure) }
    end

    context 'with invalid jwt payload' do
      let(:wrong_jwt) { Hanami::Container['jwt'].encode(username: 'wtf') }
      let(:env) { { 'HTTP_AUTHORIZATION' => "Bearer #{wrong_jwt}" } }

      it { is_expected.to eq(:failure) }
    end

    context 'without `username` in payload' do
      let(:wrong_jwt) { Hanami::Container['jwt'].encode(wtf: 'wtf') }
      let(:env) { { 'HTTP_AUTHORIZATION' => "Bearer #{wrong_jwt}" } }

      it { is_expected.to eq(:failure) }
    end
  end
end
