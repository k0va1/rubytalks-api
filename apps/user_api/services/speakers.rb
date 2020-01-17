# frozen_string_literal: true

module UserApi
  module Services
    class Speakers
      include Import[
        prepare_pagination: 'util.pagination.prepare',
        approved_list: 'domains.speakers.operations.approved_list'
      ]

      def approved_speakers_list(input)
        input = prepare_pagination.call(input)
        approved_list.call(input)
      end
    end
  end
end

