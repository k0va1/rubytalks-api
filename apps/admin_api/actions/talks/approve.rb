# frozen_string_literal: true

module AdminApi
  module Actions
    module Talks
      class Approve < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          approve: 'domains.talks.operations.approve'
        ]

        params do
          required(:id).filled(:integer)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = approve.call(input[:id])

          respond_with(response, result, Serializers::Talk)
        end
      end
    end
  end
end
