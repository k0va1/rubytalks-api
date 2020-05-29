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

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            decline.call(input[:id])
          end

          respond_with(response, result, Serializers::Talk)
        end
      end
    end
  end
end
