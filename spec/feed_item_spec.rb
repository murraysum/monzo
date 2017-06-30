require "spec_helper"

describe Monzo::FeedItem do
  context "initializing an feed item" do
    before :each do
      @feed_item = FactoryGirl.build(:feed_item)
    end

    it "should have a account id" do
      expect(@feed_item.account_id).to eql("acc_00009237aqC8c5umZmrRdh")
    end

    it "should have a type" do
      expect(@feed_item.type).to eql("basic")
    end

    it "should have params" do
      expect(@feed_item.params).to eql({
        :title => "My custom item",
        :image_url => "http://www.example.com/image.png",
        :background_color => "#FCF1EE",
        :body_color => "#FCF1E1",
        :title_color => "#333",
        :body => "Some body text to display"
      })
    end

    it "should have a url" do
      expect(@feed_item.url).to eql("https://www.example.com/a_page_to_open_on_tap.html")
    end
  end

  context ".create" do
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = FactoryGirl.attributes_for(:feed_item)

      account_id = attributes[:account_id]
      params = attributes[:params]
      url = attributes[:url]

      @stub = stub_request(:post, "https://api.monzo.com/feed")
      @stub.with({
        headers: build_request_headers(access_token),
        body: attributes
      })
      @stub.to_return(status: 200, body: {}.to_json, headers: {})

      @feed_item = Monzo::FeedItem.create(account_id, "basic", params, url)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be an instance of a Hash" do
      expect(@feed_item).to be_an_instance_of(Hash)
    end
  end
end
