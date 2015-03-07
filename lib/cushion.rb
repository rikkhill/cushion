require 'rest_client'

# There is totally going to be more stuff here
module Cushion
  class Api
    attr_reader :url
    def initialize(url, auth)
      @url = url
      @auth = auth
    end

    def arb s # arbitrary get
      RestClient.get @url + "/#{s}"
    end
  end
end
