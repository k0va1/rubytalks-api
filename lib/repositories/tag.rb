# frozen_string_literal: true

module Repositories
  class Tag < ROM::Repository[:tags]
    include Import.args[:rom]

    def create(**args)
      tags.changeset(Changesets::Tag::Create, args).commit
    end

    def find_by_slug(slug)
      tags.where(slug: slug).one
    end

    def unique_slug?(slug)
      tags.where(slug: slug).count.zero?
    end
  end
end
