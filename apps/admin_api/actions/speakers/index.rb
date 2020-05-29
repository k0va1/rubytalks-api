# frozen_string_literal: true

module AdminApi
  module Actions
    module Speakers
      class Index < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          speakers: 'admin_api.services.speakers'
        ]

        params do
          optional(:state).maybe(Types::States)
          optional(:query).maybe(:string)
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            speakers.speaker_list(input)
          end

          respond_with_collection(response, result, Serializers::Speaker)
        end
      end
    end
  end
end
