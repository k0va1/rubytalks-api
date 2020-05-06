# frozen_string_literal: true

module AdminApi
  module Serializers
    class EventWithTalksAndSpeakers < Event
      collection :talks do
        property :id
        property :title
        property :state
      end

      # TODO: fetch speakers from db
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
