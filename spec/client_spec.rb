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

  context "#get" do
    before :each do
      access_token = "abc"

      @body = {test: "body"}.to_json
      @stub = stub_request(:get, "https://api.monzo.com/test/?foo=bar").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: @body , headers: {})

      client = Monzo::Client.new(access_token)

      @response = client.get("/test/", :foo => "bar")
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should have a response code" do
      expect(@response.code).to eql("200")
    end

    it "should have a response body" do
      expect(@response.body).to eql(@body)
    end
  end

  context "#post" do
    before :each do
      access_token = "abc"

      @body = {test: "body"}.to_json
      @stub = stub_request(:post, "https://api.monzo.com/test/").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: @body , headers: {})

      client = Monzo::Client.new(access_token)

      @response = client.post("/test/", :foo => "bar")
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should have a response code" do
      expect(@response.code).to eql("200")
    end

    it "should have a response body" do
      expect(@response.body).to eql(@body)
    end
  end

  context "#patch" do
    before :each do
      access_token = "abc"

      @body = {test: "body"}.to_json
      @stub = stub_request(:patch, "https://api.monzo.com/test/").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: @body , headers: {})

      client = Monzo::Client.new(access_token)

      @response = client.patch("/test/", :foo => "bar")
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should have a response code" do
      expect(@response.code).to eql("200")
    end

    it "should have a response body" do
      expect(@response.body).to eql(@body)
    end
  end

  context "#delete" do
    before :each do
      access_token = "abc"

      @body = {test: "body"}.to_json
      @stub = stub_request(:delete, "https://api.monzo.com/test/").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: @body , headers: {})

      client = Monzo::Client.new(access_token)

      @response = client.delete("/test/")
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should have a response code" do
      expect(@response.code).to eql("200")
    end

    it "should have a response body" do
      expect(@response.body).to eql(@body)
    end
  end
end
