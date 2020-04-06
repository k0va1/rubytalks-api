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

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = create_session.call(input)

          respond_with_success(response, result.value!, with: Serializers::User, status: 201)
        end
      end
    end
  end
end
