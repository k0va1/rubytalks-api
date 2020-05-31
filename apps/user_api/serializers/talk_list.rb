# frozen_string_literal: true

module UserApi
  module Serializers
    class TalkList < Talk
      collection :tags, decorator: UserApi::Serializers::Tag
      property :event, decorator: UserApi::Serializers::Event
    end
  end
end
