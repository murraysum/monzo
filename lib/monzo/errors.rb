# frozen_string_literal: true

module Monzo
  # Internal: Exception to raise on reciept of API error.
  MonzoAPIError = Class.new(StandardError)
end
