# frozen_string_literal: true

RSpec.describe Domains::Users::Operations::CreateSession do
  subject { operation.call(params) }

  describe 'with mocks' do
    let(:operation) { described_class.new(user_repo: user_repo, jwt: jwt, password_matcher: password_matcher) }
    let(:user) { Factory.structs[:user] }
    let(:user_repo) { instance_double(Repositories::User, find_by_username: user) }
    let(:jwt) { instance_double(Jwt, encode: 'token') }
    let(:password_matcher) { instance_double(Util::PasswordMatcher, equals?: true) }

    context 'with valid params' do
      let(:params) do
        {
          username: user.username,
          password: '123123123'
        }
      end

      it 'returns success' do
        expect(subject).to be_success
      end
    end

    context 'when user is not found' do
      before do
        allow(user_repo).to receive(:find_by_username).and_return(nil)
      end

      let(:params) do
        {
          username: 'wtf',
          password: '123123123'
        }
      end

      it 'returns failure' do
        expect(subject).to be_failure
      end
    end

    context 'when password is ivalid' do
      before do
        allow(password_matcher).to receive(:equals?).and_return(false)
      end

      let(:params) do
        {
          username: user.username,
          password: 'wft'
        }
      end

      it 'returns failure' do
        expect(subject).to be_failure
      end
    end
  end
end
