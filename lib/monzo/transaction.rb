module Monzo

  # Public: Transactions are movements of funds into or out of an account.
  #         Negative transactions represent debits (ie. spending money) and
  #         positive transactions represent credits (ie. receiving money).
  class Transaction

    attr_reader :id, :created, :description, :amount, :currency,
      :merchant, :notes, :metadata, :account_balance, :attachments,
      :category, :is_load, :settled, :local_amount, :local_currency,
      :updated, :account_id, :counterparty, :scheme, :dedupe_id,
      :originator, :include_in_spending

    # Public: Initialize a Transaction.
    #
    # params - A Hash of transaction parameters.
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

    # Public: Find a transaction with the given transaction id.
    #
    # transaction_id - The id to find.
    # options - a Hash of options to request further information such as the
    #           merchant information (optional)
    #
    # Returns an instance of Monzo::Transaction.
    def self.find(transaction_id, options = {})
      response = Monzo.client.get("/transactions/#{transaction_id}", options)
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      Monzo::Transaction.new(parsed_response[:transaction])
    end

    # Public: Find all the transactions for a given account id.
    #
    # account_id - The account id to retrieve transactions from.
    #
    # Returns an Array of Monzo::Transaction.
    def self.all(account_id, options = {})
      options[:account_id] = account_id
      response = Monzo.client.get("/transactions", options)
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      parsed_response[:transactions].map do |item|
        Monzo::Transaction.new(item)
      end
    end

    # Public: Create an annotation for a given transaction id. You may store
    # your own key-value annotations against a transaction in its metadata.
    #
    # transaction_id - The transaction id to annotate.
    # metadata - a hash of annotations to add.
    #
    # Returns an instance of Monzo::Transaction with the annotations.
    def self.create_annotation(transaction_id, metadata)
      data = {}
      metadata.each do |k, v|
        data["metadata[#{k.to_s}]"] = v
      end
      response = Monzo.client.patch("/transactions/#{transaction_id}", data, {})
      parsed_response = JSON.parse(response.body, :symbolize_names => true)

      Monzo::Transaction.new(parsed_response[:transaction])
    end

  end
end
