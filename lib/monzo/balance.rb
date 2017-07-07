module Monzo

  # Public: Retrieve information about an account’s balance.
  class Balance

    attr_reader :balance, :currency, :spend_today, :local_currency,
      :local_exchange_rate, :local_spend

    # Public: Initialize a Balance.
    #
    # params - A Hash of balance parameters.
    def initialize(params)
      @balance = params[:balance]
      @currency = params[:currency]
      @spend_today = params[:spend_today]
      @local_currency = params[:local_currency]
      @local_exchange_rate = params[:local_exchange_rate]
      @local_spend = params[:local_spend]
    end

    # Public: Find the balance of the given account id.
    #
    # account_id - The Monzo account id to find the balance for.
    #
    # Returns an instance of Monzo::Balance
    def self.find(account_id)
      client = Monzo.client
      response = client.get("/balance", {:account_id => account_id})
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      Monzo::Balance.new(parsed_response)
    end
  end
end
