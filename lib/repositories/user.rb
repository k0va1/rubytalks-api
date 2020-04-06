# frozen_string_literal: true

module Repositories
  class User < ROM::Repository[:users]
    include Import.args[:rom]

    commands :create

    def find_by_username(username)
      users.where(username: username).one
    end
  end
end
