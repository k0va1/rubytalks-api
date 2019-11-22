# frozen_string_literal: true

module Repositories
  class Event < ROM::Repository[:events]
    include Import.args[:rom]

    commands :create, update: :by_pk

    def all
      events.to_a
    end

    def all_approved(limit: nil, offset: nil)
      combined = events.with_state('approved')

      return combined.to_a if limit.nil? && offset.nil?

      apply_pagination(combined, offset, limit).one!
    end

    def find_or_create(event_form)
      event = find_by_name(name: event_form[:name])
      event || create(**event_form)
    end

    def find_by_name(name:)
      root
        .where(name: name)
        .one
    end

    def find_with_talks(id:)
      events
        .combine(:talks)
        .with_state('approved')
        .by_pk(id)
        .one!
    end

    def order_by_ended_at
      root.order(:ended_at)
    end


    private

    def apply_pagination(relation, offset, limit)
      with_opts = relation.limit(limit)
      with_opts = with_opts.offset(offset) if offset.positive?

      with_opts >> Util::Pagination::Mapper.new(relation)
    end
  end
end
