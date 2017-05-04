module Monzo
  class Balance

    attr_reader :balance, :currency, :spend_today

    def initialize(params)
      @balance = params[:balance]
      @currency = params[:currency]
      @spend_today = params[:spend_today]
    end

  end
end
