FactoryGirl.define do
  factory :webhook, :class => Monzo::Webhook do
    id "webhook_000091yhhOmrXQaVZ1Irsv"
    account_id "acc_000091yf79yMwNaZHhHGzp"
    url "http://example.com/callback"

    initialize_with do
      new(attributes)
    end
  end
end
