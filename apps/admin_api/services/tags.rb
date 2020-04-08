# frozen_string_literal: true

module AdminApi
  module Services
    class Tags
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        approved_list: 'domains.tags.operations.approved_list',
        declined_list: 'domains.tags.operations.declined_list',
        unpublished_list: 'domains.tags.operations.unpublished_list'
      ]

      def approved_tags_list(input)
        input = prepare_pagination.call(input)
        approved_list.call(input)
      end

      def declined_tags_list(input)
        input = prepare_pagination.call(input)
        declined_list.call(input)
      end

      def unpublished_tags_list(input)
        input = prepare_pagination.call(input)
        unpublished_list.call(input)
      end
    end
  end
end
