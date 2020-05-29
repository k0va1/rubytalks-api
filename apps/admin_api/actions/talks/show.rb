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

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            find.call(id: input[:id])
          end

          respond_with(response, result, Serializers::TalkWithSpeakersAndEvent)
        end
      end
    end
  end
end
