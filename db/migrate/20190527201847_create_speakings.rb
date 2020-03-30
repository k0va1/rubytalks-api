# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :speakings do
      primary_key :id

      foreign_key :talk_id, :talks, null: false, on_delete: :cascade
      foreign_key :speaker_id, :speakers, null: false, on_delete: :cascade
    end
  end
end
