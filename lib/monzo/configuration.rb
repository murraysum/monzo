module Monzo

  # Internal: Store configuration options for the gem.
  class Configuration

    attr_accessor :access_token

    # Internal: Initialize a Configuration.
    #
    # access_token - The access_token to authenticate with.
    def initialize(access_token)
      @access_token = access_token
    end
  end
end
