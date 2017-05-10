$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "monzo"
require "factory_girl"
require "webmock/rspec"
require "byebug"

FactoryGirl.find_definitions

WebMock.disable_net_connect!(allow_localhost: true)
