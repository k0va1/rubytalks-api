# frozen_string_literal: true

module Repositories
  class Speaking < ROM::Repository[:speakings]
    include Import.args[:rom]

    commands :create, delete: :by_pk

    def find_or_create(speaking_form)
      ts = speakings.where(talk_id: speaking_form[:talk_id], speaker_id: speaking_form[:speaker_id]).one
      ts || create(speaking_form)
    end

    def all_by_talk_id(talk_id)
      root.where(talk_id: talk_id).to_a
    end

    def all
      speakings.to_a
    end
  end
end
