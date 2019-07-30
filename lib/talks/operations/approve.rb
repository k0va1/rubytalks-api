# frozen_string_literal: true

module Talks
  module Operations
    class Approve < Operation
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
        talk = yield find_talk(id)
        talk_repo.transaction do
          yield update_talk_state(talk.id)
          yield update_speakers_state(talk.speakers)
          yield update_event_state(talk.event_id) if talk.event_id
        end
        Success('Talk successfully approved')
      end

      private

      def find_talk(id)
        Try(ROM::TupleCountMismatchError) { talk_repo.find_unapproved(id) }.to_result
      end

      def update_talk_state(id)
        Try(Hanami::Model::Error) { talk_repo.update(id, state: 'approved') }.to_result
      end

      def update_speakers_state(speakers)
        Try(Hanami::Model::Error) do
          speakers.map(&:id).each do |speaker_id|
            speaker_repo.update(speaker_id, state: 'approved')
          end
        end.to_result
      end

      def update_event_state(event_id)
        Try(Hanami::Model::Error) { event_repo.update(event_id, state: 'approved') }.to_result
      end
    end
  end
end
