# frozen_string_literal: true

Factory.define(:taggings) do |f|
  f.association(:tag)
  f.association(:talk)
end
