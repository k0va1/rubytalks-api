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
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = speakers.approved_speakers_list(input)

          respond_with_collection(response, result, Serializers::Speaker)
        end
      end
    end
  end
end
