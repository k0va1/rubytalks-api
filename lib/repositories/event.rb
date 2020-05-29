# frozen_string_literal: true

require 'util/pagination/apply'

module Repositories
  class Event < ROM::Repository[:events]
    include Import.args[:rom]
    include ::Util::Pagination::Apply

    commands :create, update: :by_pk

    def all
      events.to_a
    end

    def find_or_create(event_form)
      event = by_pk(event_form[:id]).one if event_form[:id]
      event || events.changeset(Changesets::Event::Create, event_form).commit
    end

    def find_by_name(name:)
      root
        .where(name: name)
        .one
    end

    def find_with_talks(id:)
      events
        .combine(:talks)
        .node(:talks) { |talks| talks.combine(:speakers).where { state =~ Types::States[:approved] } }
        .with_state('approved')
        .by_pk(id)
        .one!
    end

    def find_by_id_with_talks(id:)
      events
        .combine(:talks)
        .by_pk(id)
        .one!
    end

    def order_by_ended_at
      root.order(:ended_at)
    end
  end
end
