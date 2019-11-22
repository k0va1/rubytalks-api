# frozen_string_literal: true

module UserApi
  module Actions
    module Events
      class Index < UserApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          events: 'user_api.services.events'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = events.approved_events_list(input)

          respond_with_collection(response, result, Serializers::Event)
        end
      end
    end
  end
end
