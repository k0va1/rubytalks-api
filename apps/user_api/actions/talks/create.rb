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

          required(:speakers).each(Types::Speaker)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = create.call(input)

          respond_with(response, result, Serializers::Talk)
        end
      end
    end
  end
end
