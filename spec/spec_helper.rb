$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "monzo"
require "factory_girl"
require "webmock/rspec"
require "byebug"

FactoryGirl.find_definitions

WebMock.disable_net_connect!(allow_localhost: true)

def build_request_headers(access_token)
  {
    "Accept" => "*/*",
    "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
    "Authorization" => "Bearer #{access_token}",
    "User-Agent" => "Ruby"
  }
end
