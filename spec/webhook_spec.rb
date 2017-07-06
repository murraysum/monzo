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
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = FactoryGirl.attributes_for(:webhook)
      account_id = attributes[:account_id]
      url = attributes[:url]

      @stub = stub_request(:post, "https://api.monzo.com/webhooks")
      @stub.with({
        headers: build_request_headers(access_token),
        body: {
          :account_id => account_id,
          :url => url
        }
      })
      @stub.to_return({
        status: 200,
        body: {
          :webhook => attributes
        }.to_json
      })

      @webhook = Monzo::Webhook.create(account_id, url)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be an instance of webhook" do
      expect(@webhook).to be_an_instance_of(Monzo::Webhook)
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
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = FactoryGirl.attributes_for(:webhook)
      account_id = attributes[:account_id]

      @stub = stub_request(:get, "https://api.monzo.com/webhooks?account_id=acc_000091yf79yMwNaZHhHGzp")
      @stub.with(headers: build_request_headers(access_token))
      @stub.to_return({
        status: 200,
        body: {
          :webhooks => [attributes]
        }.to_json
      })

      @webhooks = Monzo::Webhook.all(account_id)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be a list of webhooks" do
      expect(@webhooks).to be_an_instance_of(Array)
      expect(@webhooks.first).to be_an_instance_of(Monzo::Webhook)
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
      access_token = "abc"
      Monzo.configure(access_token)

      webhook_id = FactoryGirl.attributes_for(:webhook)[:id]

      @stub = stub_request(:delete, "https://api.monzo.com/webhooks/#{webhook_id}")
      @stub.with(headers: build_request_headers(access_token))
      @stub.to_return(status: 200, body: {}.to_json)

      @response_body = Monzo::Webhook.delete(webhook_id)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be an instance of a Hash" do
      expect(@response_body).to be_an_instance_of(Hash)
    end
  end
end
