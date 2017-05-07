FactoryGirl.define do
  factory :balance, :class => Monzo::Balance do
    balance 5000
    currency "GBP"
    spend_today 200
    local_currency ""
    local_exchange_rate 0
    local_spend []

    initialize_with do
      new(attributes)
    end
  end
end
