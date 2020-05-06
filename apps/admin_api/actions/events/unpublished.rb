# frozen_string_literal: true

module AdminApi
  module Actions
    module Events
      class Unpublished < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          events: 'admin_api.services.events'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = events.unpublished_events_list(input)

          respond_with_collection(response, result, Serializers::Event)
        end
      end
    end
  end
end
