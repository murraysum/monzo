require "json"

require "monzo/version"
require "monzo/errors"
require "monzo/account"
require "monzo/balance"
require "monzo/transaction"
require "monzo/feed_item"
require "monzo/pot"
require "monzo/webhook"
require "monzo/client"
require "monzo/configuration"

module Monzo

  # Public: Set the configuration options such as the accces token.
  #
  # access_token - The access_token to authenticate with.
  #
  # Returns: an instance of Monzo::Configuration.
  def self.configure(access_token)
    @configuration = Monzo::Configuration.new(access_token)
  end

  # Internal: The http client to perform requests.
  def self.client
    Monzo::Client.new(@configuration.access_token)
  end
end
