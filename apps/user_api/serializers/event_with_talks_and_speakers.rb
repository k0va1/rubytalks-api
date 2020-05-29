# frozen_string_literal: true

module UserApi
  module Serializers
    class EventWithTalksAndSpeakers < Event
      collection :talks do
        property :id
        property :title

        collection :speakers do
          property :id
          property :first_name
          property :last_name
        end
      end
    end
  end
end
