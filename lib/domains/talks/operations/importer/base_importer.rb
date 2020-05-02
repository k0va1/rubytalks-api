# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      module Importer
        module BaseImporter
          def buzzwords
            @buzzwords ||= %w[ruby rails goruco .rb euruko gogaruco]
          end
        end
      end
    end
  end
end
