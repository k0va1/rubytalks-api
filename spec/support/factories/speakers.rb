# frozen_string_literal: true

Factory.define(:speaker) do |f|
  f.first_name { Faker::Name.first_name }
  f.last_name { Faker::Name.last_name }
  f.sequence(:slug) { |i, first_name, last_name| "#{first_name}-#{last_name}#{i}".downcase }
  f.state { 'unpublished' }
  f.updated_at { Time.now }
  f.created_at { Time.now }
end

Factory.define(approved_speaker: :speaker) do |f|
  f.state 'approved'
end
