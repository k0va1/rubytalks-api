# frozen_string_literal: true

module AdminApi
  module Actions
    module Talks
      class Show < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          find: 'domains.talks.operations.find'
        ]

        params do
          required(:id).filled(:integer)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = find.call(id: input[:id])

          respond_with(response, result, Serializers::Talk)
        end
      end
    end
  end
end
