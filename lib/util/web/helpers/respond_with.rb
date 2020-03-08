# frozen_string_literal: true

module Util
  module Web
    module Helpers
      module RespondWith
        ERRORS_MAPPER = [
          { error_class: ROM::TupleCountMismatchError, status: 404, message: 'Record not found', context: nil }
        ].freeze

        def respond_with(response, result, serializer, status: 200)
          if result.success?
            respond_with_success(response, result.value!, with: serializer, status: status)
          else
            error = fetch_error(result.failure)
            respond_with_failure(response, result.failure, status: error[:status])
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
            respond_with_failure(response, result.failure, status: status)
          end
        end

        def respond_with_success(response, value, with:, base: Util::Web::Serializers::Success, status: 200)
          response.status = status
          response.body   = base.new(value, with: with).to_json
        end

        def respond_with_failure(response, _value, status: 400)
          response.status = status
        end

        def fetch_error(error_class)
          ERRORS_MAPPER.find { |error| error_class == error[:error_class] }
        end
      end
    end
  end
end
