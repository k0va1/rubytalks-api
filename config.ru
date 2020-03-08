# frozen_string_literal: true

require './config/boot'
run Hanami.app

# Sidekiq monitoring
require 'sidekiq/web'
map '/sidekiq' do
  use Rack::Auth::Basic, 'Protected Area' do |username, password|
    Helpers.compare(username, ENV['SIDEKIQ_USERNAME']) & Helpers.compare(password, ENV['SIDEKIQ_PASSWORD'])
  end

  run Sidekiq::Web
end

module Helpers
  def self.compare(a, b)
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(a), ::Digest::SHA256.hexdigest(b))
  end
end
