# frozen_string_literal: true

module Repositories
  class Speaking < ROM::Repository[:speakings]
    include Import.args[:rom]

    commands :create

    def find_or_create(speaking_form)
      ts = speakings.where(talk_id: speaking_form[:talk_id], speaker_id: speaking_form[:speaker_id]).one
      ts || create(speaking_form)
    end

    def all
      speakings.to_a
    end
  end
end
