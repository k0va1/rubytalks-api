# frozen_string_literal: true

require_relative './system/import'
require_relative './params'
require_relative '../../lib/util/web/helpers/respond_with'
require_relative '../../lib/util/web/helpers/validate_params'

module UserApi
  class Action < Hanami::Action
    include Util::Web::Helpers::RespondWith
    include Util::Web::Helpers::ValidateParams

    extend Actions::Params

    class_attribute :contract
  end

  module Actions; end
end
