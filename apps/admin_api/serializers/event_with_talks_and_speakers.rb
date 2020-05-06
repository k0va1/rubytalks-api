# frozen_string_literal: true

module AdminApi
  module Serializers
    class EventWithTalksAndSpeakers < Util::Web::Serializer
      property :id
      property :name
      property :city
      property :state
      property :started_at
      property :ended_at
      property :slug

      property :updated_at
      property :created_at

      collection :talks do
        property :id
        property :title
        property :state
      end

      # collection :speakers do
      #   property :id
      #   property :first_name
      #   property :middle_name
      #   property :last_name
      #   property :state
      # end
    end
  end
end
