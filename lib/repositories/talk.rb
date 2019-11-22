# frozen_string_literal: true

module Repositories
  class Talk < ROM::Repository[:talks]
    include Import.args[:rom]

    commands :create, update: :by_pk

    def all(limit: nil, offset: nil)
      return talks.to_a if limit.nil? && offset.nil?

      apply_pagination(talks, offset, limit).one!
    end

    def all_approved(limit: nil, offset: nil)
      combined = talks
                 .combine(:speakers, :event)
                 .with_state('approved')

      return combined.to_a if limit.nil? && offset.nil?

      apply_pagination(combined, offset, limit).one!
    end

    def all_ordered_by_created_at
      talks.order { created_at.desc }
    end

    def find_unpublished(limit: nil, offset: nil)
      combined = talks
                 .combine(:speakers, :event)
                 .with_state('unpublished')
                 .order { created_at.desc }

      return combined.to_a if limit.nil? && offset.nil?

      apply_pagination(combined, offset, limit).one!
    end

    # with state `unpublished` and `declined`
    def find_unapproved_by_id(id)
      talks
        .combine(:speakers, :event)
        .without_state('approved')
        .by_pk(id)
        .one!
    end

    def find_approved_by_id_with_speakers_and_event(id)
      talks
        .combine(:speakers, :event)
        .with_state('approved')
        .by_pk(id)
        .one!
    end

    def find_by_id_with_speakers_and_event(id)
      talks
        .combine(:speakers, :event)
        .by_pk(id)
        .one!
    end

    private

    def apply_pagination(relation, offset, limit)
      with_opts = relation.limit(limit)
      with_opts = with_opts.offset(offset) if offset.positive?

      with_opts >> Util::Pagination::Mapper.new(relation)
    end
  end
end
