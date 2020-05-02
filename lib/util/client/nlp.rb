# frozen_string_literal: true

module Util
  module Client
    class NlpClientError < StandardError; end

    class Nlp
      def initialize
        @connection = Faraday.new(ENV.fetch('NLP_API_URL'), headers: default_headers)
      end

      def fetch_people(content)
        resp = connection.get('/people') do |req|
          req.params[:q] = content
        end
        JSON.parse(resp.body)['people']
      rescue Faraday::Error => e
        raise NlpClientError, e
      end

      private

      attr_reader :connection

      def default_headers
        { content_type: 'application/json' }
      end
    end
  end
end
