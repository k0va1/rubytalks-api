# frozen_string_literal: true

require_relative './container'

module UserApi
  AppImport = UserApi::Container.injector
end

UserApi::Container.finalize!
