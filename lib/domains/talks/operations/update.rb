# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class Update
        include Operation
        include Import[
          oembed: 'oembed',
          talk_repo: 'repositories.talk',
          slug_generator: 'util.slug_generator'
        ]

        # TODO: input checking
        def call(input)
          input = yield prepare_oembed(input)
          input = yield generate_slug(input)
          talk = yield update_talk(input[:id], **input.reject { |k, _v| k == :id })
          Success(talk)
        end

        private

        def generate_slug(input)
          slug = slug_generator.call(input[:title])

          if slug
            Success(input.merge(slug: slug))
          else
            Failure('cant generate slug')
          end
        end

        def prepare_oembed(input)
          return Success(input) if input[:link].nil?

          oembed = yield generate_oembed(input[:link])

          Success(input.merge(embed_code: oembed))
        end

        def generate_oembed(link)
          Try(OEmbed::Error) { oembed.get(link).html }.to_result
        end

        def update_talk(id, input)
          talk_repo.update(id, **input)
          talk = talk_repo.talks.combine(:speakers).by_pk(id).one

          if talk
            Success(talk)
          else
            Failure('could not update talk')
          end
        end
      end
    end
  end
end
