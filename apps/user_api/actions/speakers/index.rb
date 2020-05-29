# frozen_string_literal: true

module UserApi
  module Actions
    module Speakers
      class Index < UserApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          speakers: 'user_api.services.speakers'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
          required(:query).maybe(:string)
          required(:state).value(eql?: Types::States[:approved])
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
