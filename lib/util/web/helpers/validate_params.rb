# frozen_string_literal: true

module Util
  module Web
    module Helpers
      module ValidateParams
        def validate_params(params)
          params = self.class.contract.new.call(params.to_h)
          params.success? ? Success(params.to_h) : Failure(validation: params)
        end
      end
    end
  end
end
