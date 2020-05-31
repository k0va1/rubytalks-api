# frozen_string_literal: true

module Repositories
  class Speaker < ROM::Repository[:speakers]
    include Import.args[:rom]
    include ::Util::Pagination::Apply

    commands :create, update: :by_pk

    def find_or_create(speaker_form)
      speaker = find_by_name(first_name: speaker_form[:first_name], last_name: speaker_form[:last_name])
      speaker || speakers.changeset(Changesets::Speaker::Create, **speaker_form).commit
    end

    def create(**args)
      speakers.changeset(Changesets::Speaker::Create, args).commit
    end

    def unique_slug?(slug)
      speakers.where(slug: slug).count.zero?
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
        .with_state(Types::States[:approved])
        .by_pk(id)
        .combine(:talks)
        .node(:talks) { |talks| talks.where { state =~ Types::States[:approved] } }
        .one!
    end

    def find_by_id_with_talks(id:)
      speakers
        .combine(:talks)
        .by_pk(id)
        .one!
    end
  end
end
