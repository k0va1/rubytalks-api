# frozen_string_literal: true

require 'telegram/bot'

module Util
  module Client
    class Telegram
      def initialize(client = ::Telegram::Bot::Client.new(ENV.fetch('TG_BOT_TOKEN')))
        @client = client
      end

      def send_message(chat_id, msg)
        client.api.send_message(chat_id: chat_id, text: msg)
      end

      private

      attr_reader :client
    end

    class TelegramMock
      def send_message(chat_id, msg)
        puts '### SENDING MESSAGE TO TELEGRAM ###'
        puts "Message: #{msg}"
        puts "Chat id: #{chat_id}"
      end
    end
  end
end
