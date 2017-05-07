FactoryGirl.define do
  factory :account, :class => Monzo::Account do
    id "acc_00009237aqC8c5umZmrRdh"
    description "Peter Pan's Account"
    created "2015-11-13T12:17:42Z"

    initialize_with do
      new(attributes)
    end
  end
end
