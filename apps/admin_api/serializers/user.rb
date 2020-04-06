# frozen_string_literal: true

module AdminApi
  module Serializers
    class User < Util::Web::Serializer
      property :id
      property :username
      property :access_token
    end
  end
end
