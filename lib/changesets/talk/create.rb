# frozen_string_literal: true

module Changesets
  module Talk
    class Create < ROM::Changeset::Create
      map do
        add_timestamps
      end
    end
  end
end
