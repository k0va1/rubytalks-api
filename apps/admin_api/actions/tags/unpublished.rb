# frozen_string_literal: true

module AdminApi
  module Actions
    module Tags
      class Unpublished < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          tags: 'admin_api.services.tags'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = tags.unpublished_tags_list(input)

          respond_with_collection(response, result, Serializers::Tag)
        end
      end
    end
  end
end
