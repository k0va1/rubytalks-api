# frozen_string_literal: true

module AdminApi
  module Actions
    module Talks
      class Decline < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          decline: 'domains.talks.operations.decline'
        ]

        params do
          required(:id).filled(:integer)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = decline.call(input[:id])

          respond_with(response, result, Serializers::Talk)
        end
      end
    end
  end
end
