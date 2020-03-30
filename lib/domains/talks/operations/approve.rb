# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class Approve
        include Operation
        include Import[
          talk_repo: 'repositories.talk',
          speaker_repo: 'repositories.speaker',
          event_repo: 'repositories.event'
        ]

        # set Talk state to 'approved'
        # set Speaker state to 'approved'
        # create talks_speakers relation
        # set Event state to 'approved' if Event presents
        def call(id)
          Try(ROM::TupleCountMismatchError) do
            talk = find_talk(id)

            talk_repo.transaction do
              update_speakers_state(talk.speakers)
              talk = update_talk_state(talk.id)
              update_event_state(talk.event_id) if talk.event_id

              talk
            end
          end.to_result
        end

        private

        def find_talk(id)
          talk_repo.find_unapproved_by_id(id)
        end

        def update_talk_state(id)
          talk_repo.update(id, state: 'approved')
          talk_repo.talks.combine(:speakers).by_pk(id).one
        end

        def update_speakers_state(speakers)
          speakers.map(&:id).each { |speaker_id| speaker_repo.update(speaker_id, state: 'approved') }
        end

        def update_event_state(event_id)
          event_repo.update(event_id, state: 'approved')
        end
      end
    end
  end
end
