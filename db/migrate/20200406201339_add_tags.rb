# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :tags do
      primary_key :id

      column :title, String, null: false
      column :slug, String, null: false, unique: true
      column :state, :state, null: false, default: 'unpublished'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
