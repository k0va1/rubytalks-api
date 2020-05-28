# frozen_string_literal: true

module AdminApi
  module Services
    class Tags
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        list: 'domains.tags.operations.list'
      ]

      def tag_list(input)
        input = prepare_pagination.call(input)
        list.call(input)
      end
    end
  end
end
