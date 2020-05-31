# frozen_string_literal: true

require 'dry/monads/result'

module Util
  class Validator
    include Dry::Monads::Result::Mixin

    def call(contract, attributes)
      result = contract.call(attributes)

      if result.success?
        Success(result.to_h)
      else
        Failure('invalid')
      end
    end
  end
end
