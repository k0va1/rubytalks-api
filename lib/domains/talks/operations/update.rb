# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class Update
        include Operation
        include Import[
          talk_repo: 'repositories.talk',
          speaker_repo: 'repositories.speaker',
          speaking_repo: 'repositories.speaking',
          slug_generator: 'util.slug_generator'
        ]

        # TODO: input checking
        def call(input)
          input = yield generate_slug(input)
          talk = yield update_talk(input)
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

        # TODO: refactor
        def update_talk(input) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          id = input.delete(:id)
          speaker_ids = input.delete(:speakers).to_a.flat_map(&:values)
          event_id = input.dig(:event, :id)

          talk_repo.transaction do
            talk_repo.update(id, **input.merge(event_id: event_id))

            all_speakings = speaking_repo.all_by_talk_id(id)
            all_speakings.each do |sp|
              speaking_repo.delete(sp.id) unless speaker_ids.include?(sp.speaker_id)
            end

            speaker_ids.each do |sp_id|
              speaking_repo.find_or_create(talk_id: id, speaker_id: sp_id)
            end
          end

          talk = talk_repo.talks.combine(:speakers, :event).by_pk(id).one

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
