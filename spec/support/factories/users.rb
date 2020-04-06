# frozen_string_literal: true

Factory.define(:user) do |f|
  f.username { Faker::Internet.username }
  f.password_digest { BCrypt::Password.create('123123123') }
end
