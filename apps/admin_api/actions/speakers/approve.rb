# frozen_string_literal: true

module AdminApi
  module Actions
    module Speakers
      class Approve < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          approve: 'domains.speakers.operations.approve'
        ]

        params do
          required(:id).filled(:integer)
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            approve.call(input[:id])
          end

          respond_with(response, result, Serializers::SpeakerWithTalks)
        end
      end
    end
  end
end
