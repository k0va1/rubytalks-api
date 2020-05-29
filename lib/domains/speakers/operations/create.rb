# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class Create
        include Operation
        include Import[
          speaker_repo: 'repositories.speaker',
          slug_generator: 'util.slug_generator'
        ]

        def call(params)
          slug = yield generate_slug(params)
          yield validate_slug(slug)
          speaker = yield create_speaker(params, slug)
          Success(speaker)
        end

        private

        def generate_slug(params)
          return Success(params[:slug]) if params[:slug]

          name_array = params.values_at(:first_name, :middle_name, :last_name)
          Success(slug_generator.call(name_array))
        end

        def validate_slug(slug)
          speaker_repo.unique_slug?(slug) ? Success() : Failure('speaker with this slug already exists')
        end

        def create_speaker(params, slug, state = 'approved')
          speaker = speaker_repo.create(params.merge(slug: slug, state: state))

          if speaker
            Success(speaker)
          else
            Failure('could not create speaker')
          end
        end
      end
    end
  end
end
