module Monzo
  class Balance

    attr_reader :balance, :currency, :spend_today

    def initialize(params)
      @balance = params[:balance]
      @currency = params[:currency]
      @spend_today = params[:spend_today]
    end

    def self.find(account_id)
      client = Monzo::client
      client.get("/balance", {:account_id => account_id})
    end

    private

  end
end
