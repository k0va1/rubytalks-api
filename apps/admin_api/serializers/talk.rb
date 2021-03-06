# frozen_string_literal: true

module AdminApi
  module Serializers
    class Talk < Util::Web::Serializer
      property :id
      property :title
      property :description
      property :link
      property :embed_code
      property :state
      property :slug

      property :talked_at
      property :updated_at
      property :created_at
    end
  end
end
