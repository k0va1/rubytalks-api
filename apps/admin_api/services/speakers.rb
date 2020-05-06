# frozen_string_literal: true

module AdminApi
  module Services
    class Speakers
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        approved_list: 'domains.speakers.operations.approved_list',
        declined_list: 'domains.speakers.operations.declined_list',
        unpublished_list: 'domains.speakers.operations.unpublished_list'
      ]

      def approved_speakers_list(input)
        input = prepare_pagination.call(input)
        approved_list.call(input)
      end

      def declined_speakers_list(input)
        input = prepare_pagination.call(input)
        declined_list.call(input)
      end

      def unpublished_speakers_list(input)
        input = prepare_pagination.call(input)
        unpublished_list.call(input)
      end
    end
  end
end
