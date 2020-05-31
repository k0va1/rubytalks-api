# frozen_string_literal: true

module AdminApi
  module Serializers
    class Speaker < Util::Web::Serializer
      property :id
      property :first_name
      property :middle_name
      property :last_name
      property :full_name, exec_context: :decorator
      property :slug
      property :state

      property :updated_at
      property :created_at

      def full_name
        [represented.first_name, represented.middle_name, represented.last_name].compact.join(' ')
      end
    end
  end
end
