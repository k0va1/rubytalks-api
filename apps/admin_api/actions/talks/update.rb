# frozen_string_literal: true

module AdminApi
  module Actions
    module Talks
      class Update < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          update: 'domains.talks.operations.update'
        ]

        params do
          required(:id).filled(:integer)
          optional(:title).filled(:str?)
          optional(:description).maybe(:str?)
          optional(:talked_at).filled(:str?) # TODO: check iso8601 type
          optional(:link).filled(:str?)
          optional(:event).maybe(:hash) do
            required(:id).filled(:integer)
          end
          optional(:speakers).array(:hash) do
            optional(:id).filled(:integer)
          end
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            update.call(input)
          end

          respond_with(response, result, Serializers::TalkWithSpeakersAndEvent)
        end
      end
    end
  end
end
