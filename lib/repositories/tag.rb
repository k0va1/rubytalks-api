# frozen_string_literal: true

require_relative '../util/pagination/apply'

module Repositories
  class Tag < ROM::Repository[:tags]
    include Import.args[:rom]
    include ::Util::Pagination::Apply

    def create(**args)
      tags.changeset(Changesets::Tag::Create, args).commit
    end

    def find_by_slug(slug)
      tags.where(slug: slug).one
    end

    def unique_slug?(slug)
      tags.where(slug: slug).count.zero?
    end

    def all_approved(limit: nil, offset: nil)
      all_with_state(limit, offset, 'approved')
    end

    def all_declined(limit: nil, offset: nil)
      all_with_state(limit, offset, 'declined')
    end

    def all_unpublished(limit: nil, offset: nil)
      all_with_state(limit, offset, 'unpublished')
    end

    private

    def all_with_state(limit, offset, state)
      tags_relation = tags.with_state(state)

      return tags_relation.to_a if limit.nil? && offset.nil?

      apply_pagination(tags_relation, offset, limit).one!
    end
  end
end
