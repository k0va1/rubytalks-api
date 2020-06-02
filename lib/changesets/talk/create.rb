# frozen_string_literal: true

module Changesets
  module Talk
    class Create < ROM::Changeset::Create
      include Import[
        slug_generator: 'util.slug_generator',
        talk_repo: 'repositories.talk'
      ]

      map do |tuple|
        slug = slug_generator.call(tuple[:title])
        i = 1
        loop do
          break unless talk_repo.root.where(slug: slug).one

          slug += i.to_s
          i += 1
        end

        tuple.merge(
          slug: slug,
          created_at: DateTime.now,
          updated_at: DateTime.now
        )
      end
    end
  end
end
