require "net/https"
require "uri"

module Monzo

  # Internal: A client to perform HTTPS requests to the Monzo API.
  class Client

    # Public: Returns the access token used to authenticate with.
    attr_reader :access_token

    # Public: Initialize a Monzo::Client to make HTTP requests
    #
    # access_token - The access_token to authenticate with.
    def initialize(access_token)
      @access_token = access_token
    end

    # Internal: Perform a GET request to the Monzo API.
    #
    # path - The URI path to request.
    # options - A Hash of query options to include in the URI.
    #
    # Returns a HTTP response.
    def get(path, options = {})
      uri = build_uri(path, options)

      request = Net::HTTP::Get.new(uri.request_uri)
      set_authorisation_header(request)

      response = https_client(uri).request(request)
    end

    # Internal: Perform a POST request to the Monzo API.
    #
    # path - The URI path to request.
    # data - The form data to send with the request.
    # options - A Hash of query options to include in the URI.
    #
    # Returns a HTTP response.
    def post(path, data, options = {})
      uri = build_uri(path, options)

      request = Net::HTTP::Post.new(uri.request_uri)
      set_authorisation_header(request)
      request.set_form_data(data)

      response = https_client(uri).request(request)
    end

    # Internal: Perform a PATCH request to the Monzo API.
    #
    # path - The URI path to request.
    # data - The form data to send with the request.
    # options - A Hash of query options to include in the URI.
    #
    # Returns a HTTP response.
    def patch(path, data, options = {})
      uri = build_uri(path, options)

      request = Net::HTTP::Patch.new(uri.request_uri)
      set_authorisation_header(request)
      request.set_form_data(data)

      response = https_client(uri).request(request)
    end

    # Internal: Perform a DELETE request to the Monzo API.
    #
    # path - The URI path to request.
    #
    # Returns a HTTP response.
    def delete(path)
      uri = build_uri(path)

      request = Net::HTTP::Delete.new(uri.request_uri)
      set_authorisation_header(request)

      response = https_client(uri).request(request)
    end

    private

    # Internal: Build a URI for the given path and query options
    #
    # path - The URI path for the URI.
    # options - The query options for the URI.
    #
    # Returns an instance of URI for the Monzo API.
    def build_uri(path, options = {})
      uri = URI.join(host, path)
      uri.query = URI.encode_www_form(options)
      uri
    end

    # Internal: Build a HTTPS client for the given URI for requests to be issued.
    #
    # uri - The URI for the client to request.
    #
    # Returns an instance of Net::HTTP.
    def https_client(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http
    end

    # Internal: Set an authorisation header with the access token for the request
    #
    # request - The HTTP request to add the request header
    #
    # Returns nothing.
    def set_authorisation_header(request)
      request["Authorization"] = "Bearer #{access_token}"
    end

    # Internal: The host name for the Monzo API
    #
    # Returns a host name as a String.
    def host
      "https://api.monzo.com/"
    end
  end
end
