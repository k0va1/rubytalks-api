# frozen_string_literal: true

module RubyTalks
  class AdminApiAuthentication < Warden::Manager
    def initialize(app)
      super do |manager|
        manager.default_strategies :api_authentication
        manager.failure_app = ->(_env) { [401, {}, ['access denied']] }
      end
    end
  end
end

class ApiAuthenticationStrategy < ::Warden::Strategies::Base
  include Import[
    :jwt,
    user_repo: 'repositories.user'
  ]

  def valid?
    !auth_token.nil?
  end

  def authenticate!
    payload = jwt.decode(auth_token)
    if payload && (user = user_repo.find_by_username(payload['username']))
      success!(user)
    else
      fail!('authentication failure')
    end
  end

  def auth_token
    env['HTTP_AUTHORIZATION']&.split&.last # remove leading `Bearer `
  end
end

Warden::Strategies.add(:api_authentication, ApiAuthenticationStrategy)
