# frozen_string_literal: true

module Util
  module Web
    module Helpers
      module RespondWith
        ERRORS = Hanami::Utils::Hash.deep_symbolize(YAML.load_file(Hanami.root.join('config', 'errors.yml'))).freeze

        def respond_with(response, result, serializer, status: 200)
          if result.success?
            respond_with_success(response, result.value!, with: serializer, status: status)
          else
            respond_with_failure(response, result.failure)
          end
        end

        def respond_with_collection(response, result, serializer, status: 200)
          if result.success?
            respond_with_success(
              response,
              result.value!,
              with: serializer,
              base: Util::Web::Serializers::Collection,
              status: status
            )
          else
            respond_with_failure(response, result.failure)
          end
        end

        def respond_with_success(response, value, with:, base: Util::Web::Serializers::Success, status: 200)
          response.status = status
          response.body   = base.new(value, with: with).to_json
        end

        # TODO: refactor ASAP
        def respond_with_failure(response, value, status: 400)
          if value.is_a?(Hash)
            response.body = {
              errors: [value[:validation].errors.to_h]
            }.to_json
            response.status = status
          else
            error = ERRORS.fetch(value)
            response.body = {
              error: error
            }.to_json
            response.status = error[:code]
          end
        end
      end
    end
  end
end
