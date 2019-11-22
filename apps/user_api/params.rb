# frozen_string_literal: true

module UserApi
  module Actions
    module Params
      # TODO:
      # 1. I don't like use class accessors
      # 2. must choose better name for this method. Maybe contract?

      def params(&block)
        klass = const_set(:Params, Class.new(Dry::Validation::Contract))
        klass.class_eval { params(&block) }

        self.contract = klass
      end
    end
  end
end

