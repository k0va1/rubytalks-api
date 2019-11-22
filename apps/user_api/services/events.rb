# frozen_string_literal: true

module UserApi
  module Services
    class Events
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        approved_list: 'domains.events.operations.approved_list'
      ]

      def approved_events_list(input)
        input = prepare_pagination.call(input)
        approved_list.call(input)
      end
    end
  end
end

