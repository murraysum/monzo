module Monzo
  class Webhook

    attr_reader :id, :account_id, :url

    def initialize(params)
      @id = params[:id]
      @account_id = params[:account_id]
      @url = params[:url]
    end

    def self.create(account_id, url)
      client = Monzo.client

      data = {
        "account_id" => account_id,
        "url" => url
      }
      response = client.post("/webhooks", data, {})

      json = JSON.parse(response.body, :symbolize_names => true)
      Monzo::Webhook.new(json[:webhook])
    end

    def self.all(account_id)
      client = Monzo.client

      response = client.get("/webhooks", :account_id => account_id)

      json = JSON.parse(response.body, :symbolize_names => true)

      json[:webhooks].map do |item|
        Monzo::Webhook.new(item)
      end
    end

    def self.delete(webhook_id)
      client = Monzo.client

      response = client.delete("/webhooks/#{webhook_id}")
      json = JSON.parse(response.body, :symbolize_names => true)
    end
  end
end
