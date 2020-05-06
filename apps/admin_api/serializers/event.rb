# frozen_string_literal: true

module AdminApi
  module Serializers
    class Event < Util::Web::Serializer
      property :id
      property :name
      property :city
      property :state
      property :started_at
      property :ended_at
      property :slug

      property :updated_at
      property :created_at
    end
  end
end
