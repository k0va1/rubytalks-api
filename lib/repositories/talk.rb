# frozen_string_literal: true

module Repositories
  class Talk < ROM::Repository[:talks]
    include Import.args[:rom]
    include ::Util::Pagination::Apply

    commands :create, update: :by_pk

    def all(limit: nil, offset: nil)
      return talks.to_a if limit.nil? && offset.nil?

      apply_pagination(talks, offset, limit).one!
    end

    def all_ordered_by_created_at
      talks.order { created_at.desc }
    end

    def find_or_create(talk_form)
      talk = find_by_title(title: talk_form[:title])
      talk || talks.changeset(Changesets::Talk::Create, talk_form).commit
    end

    def find_by_title(title:)
      root
        .where(title: title)
        .one
    end

    def find_unpublished(limit: nil, offset: nil)
      combined = talks
                 .with_state(Types::States[:unpublished])
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
        .combine(:speakers, :event, :tags)
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
  end
end
