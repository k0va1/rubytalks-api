# frozen_string_literal: true

module Repositories
  class Speaker < ROM::Repository[:speakers]
    include Import.args[:rom]

    commands :create, update: :by_pk

    def find_or_create(speaker_form)
      speaker = find_by_name(first_name: speaker_form[:first_name], last_name: speaker_form[:last_name])
      speaker || speakers.changeset(Changesets::Speaker::Create, **speaker_form).commit
    end

    def find_by_name(first_name: nil, last_name: nil)
      root
        .where(first_name: first_name, last_name: last_name)
        .one
    end

    def order_by_last_name(order: :asc)
      root
        .order { [last_name.send(order), first_name] }
        .to_a
    end

    def find_with_talks(id:)
      speakers
        .combine(:talks)
        .with_state('approved')
        .by_pk(id)
        .one!
    end

    def all_approved(limit: nil, offset: nil)
      combined = speakers.with_state('approved')

      return combined.to_a if limit.nil? && offset.nil?

      apply_pagination(combined, offset, limit).one!
    end

    private

    def apply_pagination(relation, offset, limit)
      with_opts = relation.limit(limit)
      with_opts = with_opts.offset(offset) if offset.positive?

      with_opts >> Util::Pagination::Mapper.new(relation)
    end
  end
end
