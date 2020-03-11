# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class Update
        include Operation
        include Import[
          speaker_repo: 'repositories.speaker'
        ]

        # TODO: input checking
        def call(input)
          speaker = speaker_repo.update(input[:id], **input.reject { |k, _v| k == :id })
          Success(speaker)
        end
      end
    end
  end
end
