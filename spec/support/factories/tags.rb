# frozen_string_literal: true

Factory.define(:tag) do |f|
  f.sequence(:title) { |n| "tag#{n}" }
  f.sequence(:slug) { |n| "tag#{n}" }
  f.state { 'unpublished' }
  f.updated_at { Time.now }
  f.created_at { Time.now }
end
