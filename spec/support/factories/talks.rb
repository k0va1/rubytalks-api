# frozen_string_literal: true

Factory.define(:talk) do |f|
  f.title { Faker::Book.title }
  f.description { Faker::Movies::Lebowski.quote }
  f.embed_code { '<iframe width="100%" height="300px" src="https://www.youtube.com/embed/0nc3SXoObs8" frameborder="0" allowfullscreen></iframe>' } # rubocop:disable Metrics/LineLength
  f.link { 'https://www.youtube.com/watch?v=t99KH0TR-J4' }
  f.slug { |title| title.gsub(/\s/, '-').downcase }
  f.talked_at { Faker::Date.backward(days: 365).to_s }
  f.updated_at { Time.now }
  f.created_at { Time.now }
  f.slug { |title| title.gsub(' ', '-').downcase }
end

Factory.define(approved_talk: :talk) do |f|
  f.state { 'approved' }
end

Factory.define(unpublished_talk: :talk) do |f|
  f.state { 'unpublished' }
end

Factory.define(declined_talk: :talk) do |f|
  f.state { 'declined' }
end
