module Monzo

  # Public: Accounts represent a store of funds, and have a list of transactions.
  class Account

    attr_reader :id, :description, :created

    # Public: Initialize an Account.
    #
    # params - A Hash of account parameters.
    def initialize(params)
      @id = params[:id]
      @description = params[:description]
      @created = params[:created]
    end

    # Public: Find all Monzo Accounts
    #
    # Returns An Array of Monzo::Account
    def self.all
      client = Monzo.client
      response = client.get("/accounts")
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      parsed_response[:accounts].map do |item|
        Monzo::Account.new(item)
      end
    end
  end
end
