require "json"

require "monzo/version"
require "monzo/account"
require "monzo/balance"
require "monzo/transaction"
require "monzo/feed_item"
require "monzo/webhook"
require "monzo/client"
require "monzo/configuration"

module Monzo
  def self.configure(access_token)
    @configuration = Monzo::Configuration.new(access_token)
  end

  def self.client
    Monzo::Client.new(@configuration.access_token)
  end
end
