# frozen_string_literal: true

require_relative './system/import'
require_relative './params'
require_relative '../../lib/util/web/helpers/respond_with'
require_relative '../../lib/util/web/helpers/validate_params'

module AdminApi
  class Action < Hanami::Action
    include Util::Web::Helpers::RespondWith
    include Util::Web::Helpers::ValidateParams

    extend Actions::Params

    class_attribute :contract

    # TODO: remove after fix https://github.com/hanami/controller/issues/307
    def call(env)
      super.to_a
    end
  end

  module Actions; end
end
