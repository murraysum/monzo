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
    before :each do
      Monzo.configure("access_token")

      attributes = {}
      attributes["webhook"] = FactoryGirl.attributes_for(:webhook)

      request_headers = {
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Authorization" => "Bearer access_token",
        "User-Agent" => "Ruby"
      }

      @stub = stub_request(:post, "https://api.monzo.com/webhooks").
        with(headers: request_headers).
        to_return(status: 200, body: attributes.to_json, headers: {})

      @webhook = Monzo::Webhook.create(attributes["webhook"]["account_id"], attributes["webhook"]["url"])
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
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

  context ".all" do
    before :each do
      Monzo.configure("access_token")

      attributes = {}
      attributes["webhooks"] = [
        FactoryGirl.attributes_for(:webhook)
      ]

      request_headers = {
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Authorization" => "Bearer access_token",
        "User-Agent" => "Ruby"
      }

      @stub = stub_request(:get, "https://api.monzo.com/webhooks?account_id=acc_000091yf79yMwNaZHhHGzp").
        with(headers: request_headers).
        to_return(status: 200, body: attributes.to_json, headers: {})

      @webhooks = Monzo::Webhook.all(attributes["webhooks"].first[:account_id])
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should have an id" do
      expect(@webhooks.first.id).to eql("webhook_000091yhhOmrXQaVZ1Irsv")
    end

    it "should have an account id" do
      expect(@webhooks.first.account_id).to eql("acc_000091yf79yMwNaZHhHGzp")
    end

    it "should have an url" do
      expect(@webhooks.first.url).to eql("http://example.com/callback")
    end
  end

  context ".delete" do
    before :each do
      Monzo.configure("access_token")

      @stub = stub_request(:delete, "https://api.monzo.com/webhooks/122").
         with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Bearer access_token', 'User-Agent'=>'Ruby'}).
         to_return(status: 200, body: {}.to_json, headers: {})

      Monzo::Webhook.delete("122")
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end
  end
end
