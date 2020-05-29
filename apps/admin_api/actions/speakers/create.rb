# frozen_string_literal: true

module AdminApi
  module Actions
    module Speakers
      class Create < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          create: 'domains.speakers.operations.create'
        ]

        params do
          required(:first_name).filled(:str?)
          required(:last_name).filled(:str?)
          optional(:middle_name).maybe(:str?)
          optional(:slug).maybe(:str?)
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            create.call(input)
          end

          respond_with(response, result, Serializers::Speaker, status: 201)
        end
      end
    end
  end
end
