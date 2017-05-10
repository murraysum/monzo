$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "monzo"
require "factory_girl"
require "webmock/rspec"

FactoryGirl.find_definitions

WebMock.disable_net_connect!(allow_localhost: true)
