# frozen_string_literal: true

module AdminApi
  module Services
    class Speakers
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        list: 'domains.speakers.operations.list'
      ]

      def speaker_list(input)
        input = prepare_pagination.call(input)
        list.call(input)
      end
    end
  end
end
