# frozen_string_literal: true

module AdminApi
  module Actions
    module Speakers
      class Update < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          update: 'domains.speakers.operations.update'
        ]

        params do
          required(:id).filled(:integer)
          optional(:first_name).filled(:str?)
          optional(:middle_name).filled(:str?)
          optional(:last_name).filled(:str?)
          optional(:slug).filled(:str?)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = update.call(input)

          respond_with_success(response, result.value!, with: Serializers::Speaker)
        end
      end
    end
  end
end
