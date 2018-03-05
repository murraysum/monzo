require "securerandom"

module Monzo

  # Public: Retrieve information about a pot. A Pot is a place to keep
  # some money separate from your main spending account.
  class Pot

    attr_reader :id, :name, :style, :balance,
      :currency, :created, :updated, :deleted

    # Public: Initialize an Pot.
    #
    # params - A Hash of pot parameters.
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @style = params[:style]
      @balance = params[:balance]
      @currency = params[:currency]
      @created = params[:created]
      @updated = params[:updated]
      @deleted = params[:deleted]
    end

    # Public: Find all Monzo Pots
    #
    # Returns An Array of Monzo::Pot
    def self.all
      response = Monzo.client.get("/pots")
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      parsed_response[:pots].map do |item|
        Monzo::Pot.new(item)
      end
    end

    # Public: Find a pot with the given pot id.
    #
    # pot_id - The id to find.
    #
    # Returns an instance of Monzo::Pot.
    def self.find(pot_id)
      response = Monzo.client.get("/pots/#{pot_id}")
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      Monzo::Pot.new(parsed_response[:pot])
    end

    # Public: Deposit Money in a pot
    #
    # amount - The amount to deposit, in pennies.
    # source_account_id - The account_id of the account to withdraw from.
    # dedupe_id (optional) - A random string, to prevent duplicate deposits.
    #
    # Returns self: a single Monzo::Pot
    def deposit!(amount, source_account_id, dedupe_id = SecureRandom.uuid)
      data = {
        amount: amount,
        source_account_id: source_account_id,
        dedupe_id: dedupe_id,
      }

      response = Monzo.client.put("/pots/#{@id}/deposit", data)
      parsed_response = parse_response(response)
      update_self(parsed_response)
    end

    # Public: Withdraw Money from a pot
    #
    # amount - The amount to withdraw, in pennies.
    # destination_account_id - The account_id of the account to deposit into.
    # dedupe_id (optional) - A random string, to prevent duplicate deposits.
    #
    # Returns self: a single Monzo::Pot
    def withdraw!(amount, destination_account_id, dedupe_id = SecureRandom.uuid)
      data = {
        amount: amount,
        destination_account_id: destination_account_id,
        dedupe_id: dedupe_id,
      }

      response = Monzo.client.put("/pots/#{@id}/withdraw", data)
      parsed_response = parse_response(response)
      update_self(parsed_response)
    end

    private

    # Private: Parse the API response
    #
    # response - A Net::HTTPResponse provided by Monzo::client
    #
    # Returns a hash representing the response or raises a MonzoAPIError
    def parse_response(response)
      parsed_response = JSON.parse(response.body, :symbolize_names => true)
      if response.code.to_i.between?(400,599)
        raise MonzoAPIError, "#{parsed_response.code}: #{parsed_response.error}"
      end
      parsed_response
    end

    # Private: Update the Pot instance variables
    #
    # parsed_response - a hash whose keys exactly match the instance variables for Monzo::Pot.
    #
    # Returns self (an instance of Monzo::Pot)
    def update_self(parsed_response)
      instance_variables.each do |iv|
        instance_variable_set(iv, parsed_response[iv.to_s[1..-1].to_sym])
      end
      self
    end
  end
end
