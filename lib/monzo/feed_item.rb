module Monzo
  class FeedItem

    attr_reader :account_id, :type, :params, :url

    def initialize(params)
      @account_id = params[:account_id]
      @type = params[:type]
      @params = params[:params]
      @url = params[:url]
    end

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
