require "spec_helper"

describe Monzo::Configuration do
  before :each do
    @access_token = "abc"
    @configuration = Monzo::Configuration.new(@access_token)
  end

  it "should have configured an access token" do
    expect(@configuration.access_token).to eql(@access_token)
  end
end
