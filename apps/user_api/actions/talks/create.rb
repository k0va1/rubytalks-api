# frozen_string_literal: true

module UserApi
  module Actions
    module Talks
      class Create < UserApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          create: 'domains.talks.operations.create'
        ]

        params do
          required(:title).filled(:string)
          required(:description).filled(:string)
          required(:link).filled(:string)
          required(:talked_at).filled(:date_time)

          optional(:speakers).each(Types::Speaker)
          optional(:event).hash do
            optional(:id).filled(:integer)
            optional(:name).filled(:string)
            optional(:city).filled(:string)
            optional(:started_at).filled(:string) # TODO: check iso8601
            optional(:ended_at).filled(:string) # TODO: check iso8601
          end

          optional(:tags).each do
            hash do
              optional(:id).filled(:integer)
              optional(:title).filled(:string)
            end
          end
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            create.call(input)
          end

          case result
          when Success
            response.body = { data: { message: 'Talk has been submitted' } }
            response.status = 201
          when Failure
            respond_with_failure(response, result.failure)
          end
        end
      end
    end
  end
end
