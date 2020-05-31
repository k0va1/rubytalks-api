# frozen_string_literal: true

module AdminApi
  module Actions
    module Events
      class Index < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          events: 'admin_api.services.events'
        ]

        params do
          optional(:state).maybe(Types::States)
          optional(:query).maybe(:string)
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            events.event_list(input)
          end

          respond_with_collection(response, result, Serializers::Event)
        end
      end
    end
  end
end
