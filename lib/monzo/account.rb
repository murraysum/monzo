module Monzo
  class Account

    attr_reader :id, :description, :created

    def initialize(params)
      @id = params[:id]
      @description = params[:description]
      @created = params[:created]
    end

    def self.all
      client = Monzo::client
      client.get("/accounts")
    end
  end
end
