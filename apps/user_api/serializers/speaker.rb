# frozen_string_literal: true

module UserApi
  module Serializers
    class Speaker < Util::Web::Serializer
      property :id
      property :first_name
      property :last_name
      property :slug
      property :state

      property :updated_at
      property :created_at
    end
  end
end
