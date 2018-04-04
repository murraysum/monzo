# frozen_string_literal: true

module Monzo
  # Internal: Exception to raise on reciept of API error.
  APIError = Class.new(StandardError)
end
