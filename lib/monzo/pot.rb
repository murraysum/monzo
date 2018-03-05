module Monzo

  # Public: Retrieve information about a pot. A Pot is a place to keep
  # some money separate from your main spending account.
  class Pot

    attr_reader :id, :name, :style, :balance,
      :currency, :created, :updated, :deleted

    # Public: Initialize an Pot.
    #
    # params - A Hash of pot parameters.
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @style = params[:style]
      @balance = params[:balance]
      @currency = params[:currency]
      @created = params[:created]
      @updated = params[:updated]
      @deleted = params[:deleted]
    end

    # Public: Find all Monzo Pots
    #
    # Returns An Array of Monzo::Pot
    def self.all
      client = Monzo.client
      response = client.get("/pots")
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      parsed_response[:pots].map do |item|
        Monzo::Pot.new(item)
      end
    end
  end
end
