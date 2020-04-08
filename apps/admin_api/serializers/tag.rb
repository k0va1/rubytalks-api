# frozen_string_literal: true

module AdminApi
  module Serializers
    class Tag < Util::Web::Serializer
      property :id
      property :title
      property :slug
      property :state

      property :updated_at
      property :created_at
    end
  end
end
