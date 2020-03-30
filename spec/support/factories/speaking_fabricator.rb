# frozen_string_literal: true

Factory.define(:speaking) do |f|
  f.association(:speaker)
  f.association(:talk)
end
