FactoryGirl.define do
  factory :pot, :class => Monzo::Pot do
    id "pot_0000778xxfgh4iu8z83nWb"
    name "Savings"
    style "beach_ball"
    balance 133700
    currency "GBP"
    created "2017-11-09T12:30:53.695Z"
    updated "2017-11-10T12:30:53.695Z"

    initialize_with do
      new(attributes)
    end
  end
end
