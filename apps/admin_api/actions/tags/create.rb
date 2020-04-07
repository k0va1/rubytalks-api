# frozen_string_literal: true

module AdminApi
  module Actions
    module Tags
      class Create < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          create: 'domains.tags.operations.create'
        ]

        params do
          required(:title).filled(:str?)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = create.call(input)

          respond_with(response, result, Serializers::Tag, status: 201)
        end
      end
    end
  end
end
