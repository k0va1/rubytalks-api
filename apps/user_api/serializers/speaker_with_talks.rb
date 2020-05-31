# frozen_string_literal: true

module UserApi
  module Serializers
    class SpeakerWithTalks < Speaker
      collection :talks do
        property :id
        property :title
      end
    end
  end
end
