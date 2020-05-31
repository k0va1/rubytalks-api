# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :taggings do
      primary_key :id

      foreign_key :tag_id, :tags, null: false
      foreign_key :talk_id, :talks, null: false

      unique(%i[tag_id talk_id])
    end
  end
end
