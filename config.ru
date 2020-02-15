# frozen_string_literal: true

require './config/boot'
run Hanami.app

# Sidekiq monitoring
require 'sidekiq/web'
map '/sidekiq' do
  use Rack::Auth::Basic, 'Protected Area' do |username, password|
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
      Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
  end

  run Sidekiq::Web
end
