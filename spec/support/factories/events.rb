# frozen_string_literal: true

Factory.define(:event) do |f|
  f.name { Faker::Book.title }
  f.city { Faker::Address.city }
  f.started_at { Time.now }
  f.ended_at { Time.now + 60 * 60 * 24 }
  f.state { 'unpublished' }
  f.created_at { Time.now }
  f.updated_at { Time.now }
end

Factory.define(approved_event: :event) do |f|
  f.state { 'approved' }
end
