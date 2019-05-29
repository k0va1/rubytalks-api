# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :talks do
      primary_key :id

      column :title, String, null: false
      column :description, String, null: false

      # it is possible to save talks without an event
      foreign_key :event_id, :events

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end