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
          result = validate_params(request.params).bind do |input|
            find_approved.call(id: input[:id])
          end

          respond_with(response, result, Serializers::SpeakerWithTalks)
        end
      end
    end
  end
end
