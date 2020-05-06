# frozen_string_literal: true

module AdminApi
  module Services
    class Events
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        approved_list: 'domains.events.operations.approved_list',
        declined_list: 'domains.events.operations.declined_list',
        unpublished_list: 'domains.events.operations.unpublished_list'
      ]

      def approved_events_list(input)
        input = prepare_pagination.call(input)
        approved_list.call(input)
      end

      def declined_events_list(input)
        input = prepare_pagination.call(input)
        declined_list.call(input)
      end

      def unpublished_events_list(input)
        input = prepare_pagination.call(input)
        unpublished_list.call(input)
      end
    end
  end
end
