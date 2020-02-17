# frozen_string_literal: true

module Repositories
  class TalksSpeaker < ROM::Repository[:talks_speakers]
    include Import.args[:rom]

    commands :create

    def find_or_create(talk_speaker_form)
      ts = talks_speakers.where(talk_id: talk_speaker_form[:talk_id], speaker_id: talk_speaker_form[:speaker_id]).one
      ts || create(talk_speaker_form)
    end

    def all
      talks_speakers.to_a
    end
  end
end
