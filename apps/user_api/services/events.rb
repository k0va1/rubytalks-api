# frozen_string_literal: true

module UserApi
  module Services
    class Events
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        list: 'domains.events.operations.list'
      ]

      def event_list(input)
        input = prepare_pagination.call(input).merge(state: Types::States[:approved])
        list.call(input)
      end
    end
  end
end
