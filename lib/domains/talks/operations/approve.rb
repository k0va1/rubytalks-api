# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class Approve
        include Operation
        include Import[
          talk_repo: 'repositories.talk',
          speaker_repo: 'repositories.speaker',
          event_repo: 'repositories.event',
          tg_client: 'util.client.telegram'
        ]

        def call(id)
          Try(ROM::TupleCountMismatchError) do
            talk = find_talk(id)

            talk_repo.transaction do
              update_speakers_state(talk.speakers)
              talk = update_talk_state(talk.id)
              update_event_state(talk.event_id) if talk.event_id
              send_notification(talk)
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
          talk_repo.talks.combine(:speakers, :event).by_pk(id).one
        end

        def update_speakers_state(speakers)
          speakers.map(&:id).each { |speaker_id| speaker_repo.update(speaker_id, state: 'approved') }
        end

        def update_event_state(event_id)
          event_repo.update(event_id, state: 'approved')
        end

        def send_notification(talk)
          msg = "New talk published!\n\n#{talk.title}\n\n#{talk.link}"
          Try { tg_client.send_message('@rubytalks', msg) }
        end
      end
    end
  end
end
