# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :events do
      primary_key :id

      column :name, String, null: false
      column :city, String

      column :started_at, DateTime
      column :ended_at, DateTime
      column :state, :state, null: false, default: 'unpublished'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
