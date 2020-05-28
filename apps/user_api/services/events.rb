# frozen_string_literal: true

module UserApi
  module Services
    class Events
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        list: 'domains.events.operations.list'
      ]

      def event_list(input)
        input = prepare_pagination.call(input)
        list.call(input)
      end
    end
  end
end
