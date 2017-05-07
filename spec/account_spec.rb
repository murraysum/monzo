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
    it "has specs" do
      skip "implement"
    end
  end
end
