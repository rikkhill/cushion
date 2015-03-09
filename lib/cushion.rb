require 'rest_client'

# There is totally going to be more stuff here
module Cushion
  class Api
    attr_reader :url
    attr_reader :db
    def initialize(url, db, auth)
      @url = url
      @auth = auth
      @db = db
    end

    def arb s # arbitrary get - probably going to be ditched
      RestClient.get @url + "/" + @db + "/#{s}"
    end

    def get_uuid
      json = RestClient.get @url + "/_uuids"
      return JSON.parse(json)['uuids'][0] # TODO make this nice
    end

    def put_document(uuid, doc)
      pp "#{@url}/#{@db}/#{uuid}"
      RestClient.put "#{@url}/#{@db}/#{uuid}", doc.to_json, :content_type => :json, :accept => :json
    end

    # TODO authentication
    # TODO view requests
    # TODO file attachments
  end
end
