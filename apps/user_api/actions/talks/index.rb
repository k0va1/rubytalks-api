# frozen_string_literal: true

module UserApi
  module Actions
    module Talks
      class Index < UserApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          talks: 'user_api.services.talks'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = talks.approved_talks_list(input)

          respond_with_collection(response, result, Serializers::Talk)
        end
      end
    end
  end
end
