# frozen_string_literal: true

module UserApi
  module Services
    class Talks
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        approved_list: 'domains.talks.operations.approved_list'
      ]

      def approved_talks_list(input)
        input = prepare_pagination.call(input)
        approved_list.call(input)
      end
    end
  end
end
