require "net/https"
require "uri"

module Monzo
  class Client

    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def get(path, options = {})
      uri = build_uri(path, options)

      request = Net::HTTP::Get.new(uri.request_uri)
      set_authorisation_header(request)

      response = https_client(uri).request(request)
    end

    def post(path, data, options = {})
      uri = build_uri(path, options)

      request = Net::HTTP::Post.new(uri.request_uri)
      set_authorisation_header(request)
      request.set_form_data(data)

      response = https_client(uri).request(request)
    end

    def patch(path, data, options = {})
      uri = build_uri(path, options)

      request = Net::HTTP::Patch.new(uri.request_uri)
      set_authorisation_header(request)
      request.set_form_data(data)

      response = https_client(uri).request(request)
    end

    def delete(path)
      uri = build_uri(path)

      request = Net::HTTP::Delete.new(uri.request_uri)
      set_authorisation_header(request)

      response = https_client(uri).request(request)
    end

    private

    def build_uri(path, options = {})
      uri = URI.join(host, path)
      uri.query = build_query(options)
      uri
    end

    def https_client(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http
    end

    def set_authorisation_header(request)
      request["Authorization"] = "Bearer #{access_token}"
    end

    def build_query(options)
      URI.encode_www_form(options)
    end

    def host
      "https://api.monzo.com/"
    end

  end
end
