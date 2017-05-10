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
      Monzo.configure("access_token")

      attributes = FactoryGirl.attributes_for(:balance)

      account_id = "acc_123"
      request_headers = {
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Authorization" => "Bearer access_token",
        "User-Agent" => "Ruby" }

      stub_request(:get, "https://api.monzo.com/balance?account_id=#{account_id}").
        with(headers: request_headers).
        to_return(status: 200, body: attributes.to_json, headers: {})

      @balance = Monzo::Balance.find(account_id)
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
