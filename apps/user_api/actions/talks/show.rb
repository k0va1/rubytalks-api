# frozen_string_literal: true

module UserApi
  module Actions
    module Talks
      class Show < UserApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          find_approved: 'domains.talks.operations.find_approved'
        ]

        params do
          required(:id).filled(:integer)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = find_approved.call(id: input[:id])

          respond_with(response, result, Serializers::Talk)
        end
      end
    end
  end
end
