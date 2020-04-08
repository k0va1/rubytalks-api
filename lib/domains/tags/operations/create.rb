# frozen_string_literal: true

module Domains
  module Tags
    module Operations
      class Create
        include Operation
        include Import[
          tag_repo: 'repositories.tag',
          slug_generator: 'util.slug_generator'
        ]

        def call(params)
          slug = yield generate_slug(params[:title])
          yield validate_slug(slug)
          tag = yield create_tag(params[:title], slug)
          Success(tag)
        end

        private

        def generate_slug(*args)
          Success(slug_generator.call(*args))
        end

        def validate_slug(slug)
          tag_repo.unique_slug?(slug) ? Success() : Failure('tag with this slug already exists')
        end

        def create_tag(title, slug, state = 'approved')
          tag = tag_repo.create(title: title, slug: slug, state: state)

          if tag
            Success(tag)
          else
            Failure('could not create tag')
          end
        end
      end
    end
  end
end
