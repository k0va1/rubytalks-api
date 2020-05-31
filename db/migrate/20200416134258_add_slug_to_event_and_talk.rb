# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table(:talks) do
      add_column :slug, String, null: false, unique: true
    end

    alter_table(:events) do
      add_column :slug, String, null: false, unique: true
    end
  end
end
