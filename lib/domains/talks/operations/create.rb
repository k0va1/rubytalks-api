# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class Create
        include Operation
        include Import[
          oembed: 'oembed',
          talk_repo: 'repositories.talk',
          speaker_repo: 'repositories.speaker',
          event_repo: 'repositories.event',
          speaking_repo: 'repositories.speaking',
          tag_repo: 'repositories.tag',
          tagging_repo: 'repositories.tagging',
          slug_generator: 'util.slug_generator'
        ]

        def call(talk_form) # rubocop:disable Metrics/AbcSize
          oembed = yield generate_oembed(talk_form[:link])

          talk_repo.transaction do
            speakers = yield find_or_create_speakers(talk_form[:speakers])
            event    = yield find_or_create_event(talk_form[:event])
            talk     = yield event ? create_talk(talk_form, oembed, event.id) : create_talk(talk_form, oembed)
            tags     = yield find_or_create_tags(talk_form[:tags])
            yield create_speakings(talk.id, speakers)
            yield create_taggings(talk.id, tags)
            Success(:created)
          end
        end

        private

        def generate_oembed(link)
          Try(OEmbed::Error) { oembed.get(link).html }.to_result
        end

        def create_speakings(talk_id, speakers)
          Dry::Monads::List[*speakers.map { |speaker| create_speaking(talk_id, speaker.id) }]
            .typed(Dry::Monads::Result)
            .traverse
        end

        # move to approve operation?
        def create_speaking(talk_id, speaker_id)
          speaking = speaking_repo.create(talk_id: talk_id, speaker_id: speaker_id)

          if speaking
            Success(speaking)
          else
            Failure('could not create speaking')
          end
        end

        def create_talk(talk_form, oembed, event_id = nil)
          talk_form = talk_form.merge(
            embed_code: oembed,
            event_id: event_id,
            state: 'unpublished'
          )

          talk = talk_repo.talks.changeset(Changesets::Talk::Create, talk_form).commit

          if talk
            Success(talk)
          else
            Failure('could not create talk')
          end
        end

        def find_or_create_speakers(speaker_forms)
          Dry::Monads::List[*speaker_forms.map(&method(:find_or_create_speaker))].typed(Dry::Monads::Result).traverse
        end

        def find_or_create_speaker(speaker_form)
          slug = slug_generator.call(speaker_form[:first_name], speaker_form[:last_name])

          speaker_form = speaker_form.transform_keys(&:to_sym).merge(
            state: 'unpublished',
            slug: slug
          )

          speaker = speaker_repo.find_or_create(speaker_form)
          speaker ? Success(speaker) : Failure('could not create speaker')
        end

        def find_or_create_event(event_form)
          return Success(nil) if event_form.empty? || event_form.nil?

          event = event_repo.find_or_create(event_form)
          event ? Success(event) : Failure('could not create event')
        end

        def find_or_create_tags(tag_forms)
          Dry::Monads::List[*tag_forms.map(&method(:find_or_create_tag))].typed(Dry::Monads::Result).traverse
        end

        def find_or_create_tag(tag_form)
          tag = tag_repo.find_or_create_by_id(tag_form)
          tag ? Success(tag) : Failure('could not create tag')
        end

        def create_tagging(talk_id, tag_id)
          tagging = tagging_repo.create(talk_id: talk_id, tag_id: tag_id)

          if tagging
            Success(tagging)
          else
            Failure('could not create tagging')
          end
        end

        def create_taggings(talk_id, tags)
          Dry::Monads::List[*tags.map { |tag| create_tagging(talk_id, tag.id) }]
            .typed(Dry::Monads::Result)
            .traverse
        end
      end
    end
  end
end
