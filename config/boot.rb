# frozen_string_literal: true

require 'bundler/setup'
require 'hanami'
require 'sidekiq'

Bundler.require(:default, :development)

require_relative './application'

Hanami.boot
