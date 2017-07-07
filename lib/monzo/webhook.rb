module Monzo

  # Public: Webhooks allow your application to receive real-time,
  #         push notification of events in an account.
  class Webhook

    attr_reader :id, :account_id, :url

    # Public: Initialize a Webhook.
    #
    # params - A Hash of webhook parameters.
    def initialize(params)
      @id = params[:id]
      @account_id = params[:account_id]
      @url = params[:url]
    end

    # Public: Create a webhook for the given account id.
    #
    # account_id - The account to receive event notifications for.
    # url - The URL Monzo will send notifications to.
    #
    # Returns an instance of Monzo::Webhook.
    def self.create(account_id, url)
      client = Monzo.client

      data = {
        "account_id" => account_id,
        "url" => url
      }
      response = client.post("/webhooks", data, {})

      parsed_response = JSON.parse(response.body, :symbolize_names => true)
      Monzo::Webhook.new(parsed_response[:webhook])
    end

    # Public: Find all webhooks for a given account id.
    #
    # account_id - The account id to list registered webhooks for.
    #
    # Returns an Array of Monzo::Webhook instances.
    def self.all(account_id)
      client = Monzo.client

      response = client.get("/webhooks", :account_id => account_id)

      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      parsed_response[:webhooks].map do |item|
        Monzo::Webhook.new(item)
      end
    end

    # Public: Delete a webhook.
    #
    # webhook_id - The webhook id to be deleted.
    #
    # Returns an empty Hash.
    def self.delete(webhook_id)
      client = Monzo.client

      response = client.delete("/webhooks/#{webhook_id}")
      JSON.parse(response.body, :symbolize_names => true)
    end
  end
end
