# frozen_string_literal: true

module UserApi
  module Serializers
    class Talk < Util::Web::Serializer
      property :id
      property :title
      property :description
      property :link
      property :embed_code

      property :talked_at
      property :updated_at
      property :created_at

      collection :speakers, decorator: UserApi::Serializers::Speaker
    end

    class TalkWithSpeakersEventAndTags < Talk
      collection :speakers, decorator: UserApi::Serializers::Speaker
      collection :tags, decorator: UserApi::Serializers::Tag
      property :event, decorator: UserApi::Serializers::Event
    end
  end
end
