# frozen_string_literal: true

module Repositories
  class Tagging < ROM::Repository[:taggings]
    include Import.args[:rom]

    commands :create

    def find_or_create(params)
      tagging = taggings.where(talk_id: params[:talk_id], tag_id: params[:tag_id]).one
      tagging || create(params)
    end

    def all
      taggings.to_a
    end
  end
end
