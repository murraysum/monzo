require "spec_helper"

describe Monzo::Balance do
  context "initializing a balance" do
    before :each do
      @balance = FactoryGirl.build(:balance)
    end

    it "should have a balance" do
      expect(@balance.balance).to eql(5000)
    end

    it "should have a currency" do
      expect(@balance.currency).to eql("GBP")
    end

    it "should have the amount spent today" do
      expect(@balance.spend_today).to eql(200)
    end

    it "should have a local currency" do
      expect(@balance.local_currency).to eql("")
    end

    it "should have a local exchange rate" do
      expect(@balance.local_exchange_rate).to eql(0)
    end

    it "should have the amount spent locally" do
      expect(@balance.local_spend).to eql([])
    end
  end

  context ".find" do
    it "has specs" do
      skip "implement"
    end
  end
end
