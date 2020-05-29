# frozen_string_literal: true

module UserApi
  module Serializers
    class Tag < Util::Web::Serializer
      property :id
      property :title
      property :slug
    end
  end
end


