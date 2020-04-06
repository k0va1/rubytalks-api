# frozen_string_literal: true

module Util
  class PasswordMatcher
    def equals?(password_digest, raw_password)
      BCrypt::Password.new(password_digest) == raw_password
    end

    def encode(raw_password)
      BCrypt::Password.create(raw_password)
    end
  end
end
