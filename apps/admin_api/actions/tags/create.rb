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

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            create.call(input)
          end

          respond_with(response, result, Serializers::Tag, status: 201)
        end
      end
    end
  end
end
