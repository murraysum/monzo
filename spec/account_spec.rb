require "spec_helper"

describe Monzo::Account do
  context "initializing an account" do
    before :each do
      @account = FactoryGirl.build(:account)
    end

    it "should have an id" do
      expect(@account.id).to eql("acc_00009237aqC8c5umZmrRdh")
    end

    it "should have a description" do
      expect(@account.description).to eql("Peter Pan's Account")
    end

    it "should have a created date" do
      expect(@account.created).to eql("2015-11-13T12:17:42Z")
    end
  end

  context ".all" do
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = {}
      attributes["accounts"] = [FactoryGirl.attributes_for(:account)]

      @stub = stub_request(:get, "https://api.monzo.com/accounts")
      @stub.with(headers: build_request_headers(access_token))
      @stub.to_return(status: 200, body: attributes.to_json, headers: {})

      @accounts = Monzo::Account.all
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be a list of accounts" do
      expect(@accounts).to be_an_instance_of(Array)
      expect(@accounts.first).to be_an_instance_of(Monzo::Account)
    end

    it "should have an id" do
      expect(@accounts.first.id).to eql("acc_00009237aqC8c5umZmrRdh")
    end

    it "should have a description" do
      expect(@accounts.first.description).to eql("Peter Pan's Account")
    end

    it "should have a created date" do
      expect(@accounts.first.created).to eql("2015-11-13T12:17:42Z")
    end
  end
end
