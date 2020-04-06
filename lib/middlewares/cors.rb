# frozen_string_literal: true

module RubyTalks
  class Cors
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers = headers.merge(cors_headers)
      [status, headers, response]
    end

    def cors_headers
      { 'Access-Control-Allow-Origin' => ENV.fetch('ALLOW_ORIGIN'),
        'Access-Control-Allow-Methods' => %w[GET POST PUT PATCH OPTIONS DELETE].join(','),
        'Access-Control-Allow-Headers' => %w[Content-Type Accept Authorization].join(',') }
    end
  end
end
