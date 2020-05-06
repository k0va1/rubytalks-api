# frozen_string_literal: true

module AdminApi
  module Serializers
    class SpeakerWithTalks < Speaker
      collection :talks do
        property :id
        property :title
        property :state
      end
    end
  end
end
