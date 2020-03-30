# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :speakings do
      add_index %i[talk_id speaker_id], unique: true
    end
  end
end
