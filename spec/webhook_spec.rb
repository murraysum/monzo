require "spec_helper"

describe Monzo::Webhook do
  context "initializing a webhook" do
    before :each do
      @webhook = FactoryGirl.build(:webhook)
    end

    it "should have an id" do
      expect(@webhook.id).to eql("webhook_000091yhhOmrXQaVZ1Irsv")
    end

    it "should have an account id" do
      expect(@webhook.account_id).to eql("acc_000091yf79yMwNaZHhHGzp")
    end

    it "should have an url" do
      expect(@webhook.url).to eql("http://example.com/callback")
    end
  end

  context ".create" do
    it "has specs" do
      skip "implement"
    end
  end

  context ".all" do
    it "has specs" do
      skip "implement"
    end
  end

  context ".delete" do
    it "has specs" do
      skip "implement"
    end
  end
end
