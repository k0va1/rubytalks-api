# frozen_string_literal: true

module UserApi
  module Actions
    module Tags
      class Index < UserApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          tags: 'user_api.services.tags'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
          required(:query).maybe(:string)
          required(:state).value(eql?: Types::States[:approved])
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            tags.tag_list(input)
          end

          respond_with_collection(response, result, Serializers::Tag)
        end
      end
    end
  end
end
