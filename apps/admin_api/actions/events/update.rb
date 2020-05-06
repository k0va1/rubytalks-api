# frozen_string_literal: true

module AdminApi
  module Actions
    module Events
      class Update < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          update: 'domains.events.operations.update'
        ]

        params do
          required(:id).filled(:integer)
          optional(:name).filled(:str?)
          optional(:city).filled(:str?)
          optional(:slug).filled(:str?)
          optional(:started_at).filled(:str?) # TODO: check iso8601
          optional(:ended_at).filled(:str?) # TODO: check iso8601
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = update.call(input)

          respond_with_success(response, result.value!, with: Serializers::Event)
        end
      end
    end
  end
end
