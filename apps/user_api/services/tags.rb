# frozen_string_literal: true

module UserApi
  module Services
    class Tags
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        list: 'domains.tags.operations.list'
      ]

      def tag_list(input)
        input = prepare_pagination.call(input).merge(state: Types::States[:approved])
        list.call(input)
      end
    end
  end
end
