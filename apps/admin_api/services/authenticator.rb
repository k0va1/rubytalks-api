# frozen_string_literal: true

module AdminApi
  module Services
    class Authenticator
      def call(context)
        context.authenticate!
      end
    end
  end
end
