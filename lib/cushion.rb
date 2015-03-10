require 'rest_client'

# There is totally going to be more stuff here
module Cushion
  class Api
    attr_reader :host, :db
    def initialize(host, db, auth)
      @host = host
      @auth = auth
      @db = db
    end

    def arb s # arbitrary get - probably going to be ditched
      RestClient.get uri( @host, @db, s )
    end

    def tap_host
      JSON.parse(RestClient.get uri( @host ))
    end

    def tap_db
      JSON.parse(RestClient.get uri( @host, @db ))
    end

    def get_uuid
      json = RestClient.get uri( @host, "_uuids" )
      return JSON.parse(json)['uuids'][0] # TODO make this nice
    end

    def put_document(uuid, doc)
      RestClient.put uri([@host, @db, uuid]), doc.to_json, :content_type => :json, :accept => :json
    end

    def post_document(doc)
      RestClient.post uri( @host, @db ), doc.to_json, :content_type => :json, :accept => :json
    end

    def get_document(uuid)
      return JSON.parse(RestClient.get uri( @host, @db, uuid ))
    end

    def delete_document(uuid, rev)
      return JSON.parse(RestClient.delete uri( @host, @db, uuid ), :params => {
        :rev => rev
      })
    end


    def uri *elements
      return elements.join("/")
    end

    private :uri

    # TODO authentication
    # TODO view requests
    # TODO file attachments
  end
end
