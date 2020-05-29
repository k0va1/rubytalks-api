# frozen_string_literal: true

module AdminApi
  module Actions
    module Sessions
      class Create < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          authenticator: 'admin_api.services.blank_authenticator'
        ]
        include Import[
          create_session: 'domains.users.operations.create_session'
        ]

        params do
          required(:username).filled(:str?)
          required(:password).filled(:str?)
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            create_session.call(input)
          end

          respond_with(response, result, Serializers::User, status: 201)
        end
      end
    end
  end
end
