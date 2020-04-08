# frozen_string_literal: true

module Util
  module Pagination
    module Apply
      def apply_pagination(relation, offset, limit)
        with_opts = relation.limit(limit)
        with_opts = with_opts.offset(offset) if offset.positive?

        with_opts >> Util::Pagination::Mapper.new(relation)
      end
    end
  end
end
