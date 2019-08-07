# frozen_string_literal: true

module Talks
  module Operations
    class List < Operation
      include Import[
        talk_repo: 'repositories.talk'
      ]

      PAGINATION_LIMIT = 10
      DEFAULT_PAGE = 1

      def call(page:)
        talks = talk_repo.latest(amount: PAGINATION_LIMIT, page: page || DEFAULT_PAGE)
        pager = talk_repo.latest_pager(amount: PAGINATION_LIMIT, page: page || DEFAULT_PAGE)
        Success(result: talks, pager: pager)
      end
    end
  end
end
