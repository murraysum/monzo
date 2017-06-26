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
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = FactoryGirl.attributes_for(:balance)

      account_id = "acc_123"

      @stub = stub_request(:get, "https://api.monzo.com/balance?account_id=#{account_id}").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: attributes.to_json, headers: {})

      @balance = Monzo::Balance.find(account_id)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be an instance of balance" do
      expect(@balance).to be_an_instance_of(Monzo::Balance)
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
end
