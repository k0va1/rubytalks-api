# frozen_string_literal: true

module AdminApi
  module Serializers
    class TalkWithSpeakersAndEvent < Talk
      collection :speakers, decorator: AdminApi::Serializers::Speaker
      property :event, decorator: AdminApi::Serializers::Event
    end
  end
end
