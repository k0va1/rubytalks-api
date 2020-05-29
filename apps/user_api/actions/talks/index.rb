# frozen_string_literal: true

module UserApi
  module Actions
    module Talks
      class Index < UserApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          talks: 'user_api.services.talks'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
          required(:query).maybe(:string)
          required(:state).value(eql?: Types::States[:approved])
        end

        def handle(request, response)
          result = validate_params(request.params).bind do |input|
            talks.talk_list(input)
          end

          respond_with_collection(response, result, Serializers::TalkList)
        end
      end
    end
  end
end
