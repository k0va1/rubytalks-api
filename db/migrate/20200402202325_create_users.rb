# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table(:users) do
      primary_key :id

      column :username, String, null: false, unique: true
      column :password_digest, String, null: false
    end
  end
end
