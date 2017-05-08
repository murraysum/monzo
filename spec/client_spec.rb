require "spec_helper"

describe Monzo::Client do

  context "initializing an account" do
    before :each do
      @access_token = "abc"
      @client = Monzo::Client.new(@access_token)
    end

    it "should have an access token" do
      expect(@client.access_token).to eql(@access_token)
    end
  end

  it "#get" do
    skip "implement"
  end

  it "#post" do
    skip "implement"
  end

  it "#delete" do
    skip "implement"
  end
end
