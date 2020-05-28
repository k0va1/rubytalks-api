# frozen_string_literal: true

module UserApi
  module Services
    class Talks
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        list: 'domains.talks.operations.list'
      ]

      def talk_list(input)
        input = prepare_pagination.call(input)
        list.call(input)
      end
    end
  end
end
