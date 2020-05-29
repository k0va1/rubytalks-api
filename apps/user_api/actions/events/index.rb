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
          optional(:query).maybe(:string)
          required(:state).value(eql?: Types::States[:approved])
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
