require "spec_helper"

describe Monzo::Transaction do
  context "initializing a transaction" do
    before :each do
      @transaction = FactoryGirl.build(:transaction)
    end

    it "should have an id" do
      expect(@transaction.id).to eql("tx_00008zIcpb1TB4aeIFXMzx")
    end

    it "should have a created date" do
      expect(@transaction.created).to eql("2017-03-30T09:44:29.087Z")
    end

    it "should have a description" do
      expect(@transaction.description).to eql("SEVEN ELEVEN TOYKO")
    end

    it "should have an amount" do
      expect(@transaction.amount).to eql(-510)
    end

    it "should have a currency" do
      expect(@transaction.currency).to eql("GBP")
    end

    it "should have a merchant" do
      expect(@transaction.merchant).to eql("merch_000091i4aK4HVNXSayWZiD")
    end

    it "should have notes" do
      expect(@transaction.notes).to eql("a note")
    end

    it "should have metadata" do
      expect(@transaction.metadata).to eql({:trip_id => "trip_00002At41IVaHGr9HrabW6"})
    end

    it "should have an account balance" do
      expect(@transaction.account_balance).to eql(13013)
    end

    it "should have a set of attachments" do
      expect(@transaction.attachments).to eql([])
    end

    it "should have a category" do
      expect(@transaction.category).to eql("cash")
    end

    it "should have a is load" do
      expect(@transaction.is_load).to be false
    end

    it "should have a settled date" do
      expect(@transaction.settled).to eql("2017-03-31T04:10:28.243Z")
    end

    it "should have a local amount " do
      expect(@transaction.local_amount).to eql(-10000)
    end

    it "should have a local currency" do
      expect(@transaction.local_currency).to eql("JPY")
    end

    it "should have an updated date" do
      expect(@transaction.updated).to eql("2017-03-31T06:32:07.475Z")
    end

    it "should have an account id" do
      expect(@transaction.account_id).to eql("acc_00009237aqC8c5umZmrRdh")
    end

    it "should have a counterparty" do
      expect(@transaction.counterparty).to eql({})
    end

    it "should have a scheme" do
      expect(@transaction.scheme).to eql("gps_mastercard")
    end

    it "should have a dedupe id" do
      expect(@transaction.dedupe_id).to eql("276938521160230262509058616")
    end

    it "should have an originator" do
      expect(@transaction.originator).to be false
    end

    it "should have an include in spending" do
      expect(@transaction.include_in_spending).to be true
    end
  end

  context ".find" do
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = {}
      attributes["transaction"] = FactoryGirl.attributes_for(:transaction)

      transaction_id = attributes["transaction"]["transaction_id"]

      @stub = stub_request(:get, "https://api.monzo.com/transactions/#{transaction_id}").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: attributes.to_json, headers: {})

      @transaction = Monzo::Transaction.find(transaction_id)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be an instance of transaction" do
      expect(@transaction).to be_an_instance_of(Monzo::Transaction)
    end

    it "should have an id" do
      expect(@transaction.id).to eql("tx_00008zIcpb1TB4aeIFXMzx")
    end
  end

  context ".all" do
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = {}
      attributes["transactions"] = [
        FactoryGirl.attributes_for(:transaction)
      ]

      account_id = "acc_00009237aqC8c5umZmrRdh"

      @stub = stub_request(:get, "https://api.monzo.com/transactions?account_id=#{account_id}").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: attributes.to_json, headers: {})

      @transactions = Monzo::Transaction.all(account_id)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be a list of transactions" do
      expect(@transactions).to be_an_instance_of(Array)
      expect(@transactions.first).to be_an_instance_of(Monzo::Transaction)
    end

    it "should have an id" do
      expect(@transactions.first.id).to eql("tx_00008zIcpb1TB4aeIFXMzx")
    end
  end

  context ".create_annotation" do
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = {}
      attributes["transaction"] = FactoryGirl.attributes_for(:transaction)

      metadata = { :foo => "bar" }

      attributes["transaction"][:metadata].merge!(metadata)

      transaction_id = attributes["transaction"]["transaction_id"]

      @stub = stub_request(:patch, "https://api.monzo.com/transactions/#{transaction_id}").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: attributes.to_json, headers: {})


      @transaction = Monzo::Transaction.create_annotation(transaction_id, metadata)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be an instance of transaction" do
      expect(@transaction).to be_an_instance_of(Monzo::Transaction)
    end

    it "should have an id" do
      expect(@transaction.id).to eql("tx_00008zIcpb1TB4aeIFXMzx")
    end

    it "should have added an annotation" do
      expect(@transaction.metadata[:foo]).to eql("bar")
    end

  end
end
