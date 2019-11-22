# frozen_string_literal: true

module UserApi
  module Actions
    module Speakers
      class Show < UserApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          find_approved: 'domains.speakers.operations.find_approved'
        ]

        params do
          required(:id).filled(:integer)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = find_approved.call(id: input[:id])

          respond_with(response, result, Serializers::Speaker)
        end
      end
    end
  end
end
