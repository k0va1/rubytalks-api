# frozen_string_literal: true

module AdminApi
  module Actions
    module Talks
      class Index < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          talks: 'admin_api.services.talks'
        ]

        params do
          optional(:state).filled(Types::States)
          optional(:query).maybe(:string)
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            talks.talk_list(input)
          end

          respond_with_collection(response, result, Serializers::Talk)
        end
      end
    end
  end
end
