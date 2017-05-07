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
        "title" => "My custom item",
        "image_url" => "http://www.example.com/image.png",
        "background_color" => "#FCF1EE",
        "body_color" => "#FCF1E1",
        "title_color" => "#333",
        "body" => "Some body text to display"
      })
    end

    it "should have a url" do
      expect(@feed_item.url).to eql("https://www.example.com/a_page_to_open_on_tap.html")
    end
  end

  context ".create" do
    it "has specs" do
      skip "implement"
    end
  end
end
