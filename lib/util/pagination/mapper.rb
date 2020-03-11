# frozen_string_literal: true

module Util
  module Pagination
    class Mapper
      def initialize(relation)
        @relation = relation
      end

      def call(with_opts) # rubocop:disable Metrics/AbcSize
        limit = with_opts.source.dataset.opts[:limit]
        offset = with_opts.source.dataset.opts[:offset] || 1

        total = relation.count
        page = offset / limit + 1
        total_pages = (total / limit.to_f).ceil

        collection = Entities::PaginatedCollection.new(
          data: with_opts.to_a,
          meta: {
            page: page,
            per_page: limit,
            total: total,
            total_pages: total_pages
          }
        )

        [collection] # I have no idea how avoid that
      end

      private

      attr_reader :relation
    end
  end
end
