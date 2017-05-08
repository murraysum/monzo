module Monzo
  class Transaction

    attr_reader :id, :created, :description, :amount, :currency,
      :merchant, :notes, :metadata, :account_balance, :attachments,
      :category, :is_load, :settled, :local_amount, :local_currency,
      :updated, :account_id, :counterparty, :scheme, :dedupe_id,
      :originator, :include_in_spending

    def initialize(params)
      @id = params[:id]
      @created = params[:created]
      @description = params[:description]
      @amount = params[:amount]
      @currency = params[:currency]
      @merchant = params[:merchant]
      @notes = params[:notes]
      @metadata = params[:metadata]
      @account_balance = params[:account_balance]
      @attachments = params[:attachments]
      @category = params[:category]
      @is_load = params[:is_load]
      @settled = params[:settled]
      @local_amount = params[:local_amount]
      @local_currency = params[:local_currency]
      @updated = params[:updated]
      @account_id = params[:account_id]
      @counterparty = params[:counterparty]
      @scheme = params[:scheme]
      @dedupe_id = params[:dedupe_id]
      @originator = params[:originator]
      @include_in_spending = params[:include_in_spending]
    end

    def self.find(transaction_id, options = {})
      response = Monzo.client.get("/transactions/#{transaction_id}", options)
      json = JSON.parse(response.body, :symbolize_names => true)

      Monzo::Transaction.new(json[:transaction])
    end

    def self.all(account_id)
      response = Monzo.client.get("/transactions", :account_id => account_id)
      json = JSON.parse(response.body, :symbolize_names => true)

      json[:transactions].map do |item|
        Monzo::Transaction.new(item)
      end
    end

    def self.create_annotation(transaction_id, metadata)
      data = {}
      metadata.each do |k, v|
        data["metadata[#{k.to_s}]"] = v
      end
      response = Monzo.client.patch("/transactions/#{transaction_id}", data, {})
      json = JSON.parse(response.body, :symbolize_names => true)

      Monzo::Transaction.new(json[:transaction])
    end

  end
end
