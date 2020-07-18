# frozen_string_literal: true

Hanami::Container.boot(:jwt) do |_container|
  init do
    require 'dotenv' if defined?(Dotenv)
    require 'jwt'

    class Jwt
      EXP_TIME = 86_400 # 24 hours

      def encode(payload, exp = EXP_TIME + Time.now.to_i)
        payload[:exp] = exp.to_i
        JWT.encode(payload, ENV.fetch('JWT_SECRET'))
      end

      def decode(token)
        JWT.decode(token, ENV.fetch('JWT_SECRET'))&.first
      rescue JWT::ExpiredSignature, JWT::DecodeError
        nil
      end
    end

    register(:jwt, Jwt.new)
  end
end
