# frozen_string_literal: true

module Domains
  module Users
    module Operations
      class CreateSession
        AuthData = Struct.new(:id, :username, :access_token)

        include Operation
        include Import[
          user_repo: 'repositories.user',
          password_matcher: 'util.password_matcher',
          jwt: 'jwt'
        ]

        def call(params)
          user = user_repo.find_by_username(params[:username])

          if user && password_matcher.equals?(user.password_digest, params[:password])
            Success(AuthData.new(user.id, user.username, encoded_token(user.username)))
          else
            Failure(:invalid_credentials)
          end
        end

        private

        def encoded_token(username)
          jwt.encode(username: username)
        end
      end
    end
  end
end
