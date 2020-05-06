# frozen_string_literal: true

module AdminApi
  module Actions
    module Speakers
      class Show < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          find: 'domains.speakers.operations.find'
        ]

        params do
          required(:id).filled(:integer)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = find.call(id: input[:id])

          respond_with(response, result, Serializers::SpeakerWithTalks)
        end
      end
    end
  end
end
