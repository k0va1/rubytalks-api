# frozen_string_literal: true

ROM::SQL.migration do
  change do
    execute "CREATE TYPE state AS ENUM ('unpublished', 'approved', 'declined');"

    create_table :speakers do
      primary_key :id

      column :first_name, String, null: false
      column :last_name, String, null: false
      column :middle_name, String
      column :slug, String, null: false
      column :state, :state, null: false, default: 'unpublished'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
