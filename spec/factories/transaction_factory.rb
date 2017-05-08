FactoryGirl.define do
  factory :transaction, :class => Monzo::Transaction do
    id "tx_00008zIcpb1TB4aeIFXMzx"
    created "2017-03-30T09:44:29.087Z"
    description "SEVEN ELEVEN TOYKO"
    amount -510
    currency "GBP"
    merchant "merch_000091i4aK4HVNXSayWZiD"
    notes "a note"
    metadata ({:trip_id => "trip_00002At41IVaHGr9HrabW6"})
    account_balance 13013
    attachments []
    category "cash"
    is_load false
    settled "2017-03-31T04:10:28.243Z"
    local_amount -10000
    local_currency "JPY"
    updated "2017-03-31T06:32:07.475Z"
    account_id "acc_00009237aqC8c5umZmrRdh"
    counterparty({})
    scheme "gps_mastercard"
    dedupe_id "276938521160230262509058616"
    originator false
    include_in_spending true

    initialize_with do
      new(attributes)
    end
  end
end
