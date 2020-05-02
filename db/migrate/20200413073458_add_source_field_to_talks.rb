# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table(:talks) do
      add_column :source, String
      add_column :source_id, String
    end
  end
end
