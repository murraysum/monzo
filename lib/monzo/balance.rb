module Monzo
  class Balance

    attr_reader :balance, :currency, :spend_today, :local_currency,
      :local_exchange_rate, :local_spend

    def initialize(params)
      @balance = params[:balance]
      @currency = params[:currency]
      @spend_today = params[:spend_today]
      @local_currency = params[:local_currency]
      @local_exchange_rate = params[:local_exchange_rate]
      @local_spend = params[:local_spend]
    end

    def self.find(account_id)
      client = Monzo.client
      response = client.get("/balance", {:account_id => account_id})
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      Monzo::Balance.new(parsed_response)
    end

  end
end
