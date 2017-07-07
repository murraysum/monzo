module Monzo

  # Public: The Monzo app is organised around the feed – a
  #         reverse-chronological stream of events. Transactions
  #         are one such feed item, and your application can
  #         create its own feed items to surface relevant information
  #         to the user.
  class FeedItem

    attr_reader :account_id, :type, :params, :url

    # Public: Initialize a FeedItem.
    #
    # params - A Hash of feed item parameters.
    def initialize(params)
      @account_id = params[:account_id]
      @type = params[:type]
      @params = params[:params]
      @url = params[:url]
    end

    # Public: Create a feed item on a user's feed.
    #
    # account_id - The account id to create a feed item for.
    # type - Type of feed item. Currently only basic is supported.
    # params - A Hash of parameters which vary based on type.
    # url - A URL to open when the feed item is tapped.
    #       If no URL is provided, the app will display a fallback
    #       view based on the title & body. (optional)
    #
    # Returns: An empty Hash.
    def self.create(account_id, type, params, url = nil)
      client = Monzo.client

      data = {
        "account_id" => account_id,
        "type" => type,
        "params[title]" => params[:title],
        "params[image_url]" => params[:image_url],
        "params[background_color]" => params[:background_color],
        "params[body_color]" => params[:body_color],
        "params[title_color]" => params[:title_color],
        "params[body]" => params[:body],
        "url" => url
      }
      response = client.post("/feed", data, {})
      JSON.parse(response.body, :symbolize_names => true)
    end
  end
end
