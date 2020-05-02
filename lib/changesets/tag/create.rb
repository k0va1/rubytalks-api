# frozen_string_literal: true

module Changesets
  module Tag
    class Create < ROM::Changeset::Create
      include Import[
        slug_generator: 'util.slug_generator'
      ]

      map do |tuple|
        tuple.merge(
          slug: slug_generator.call(tuple[:title]),
          created_at: DateTime.now,
          updated_at: DateTime.now
        )
      end
    end
  end
end
