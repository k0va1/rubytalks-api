# frozen_string_literal: true

module AdminApi
  module Actions
    module Events
      class Show < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          find: 'domains.events.operations.find'
        ]

        params do
          required(:id).filled(:integer)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = find.call(id: input[:id])

          respond_with(response, result, Serializers::EventWithTalksAndSpeakers)
        end
      end
    end
  end
end
