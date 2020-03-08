# frozen_string_literal: true

module Domains
  module Events
    module Operations
      class Update
        include Operation
        include Import[
          event_repo: 'repositories.event'
        ]

        # TODO: input checking
        def call(input)
          event = event_repo.update(input[:id], **input.reject { |k, _v| k == :id })
          Success(event)
        end
      end
    end
  end
end
