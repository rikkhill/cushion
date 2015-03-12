require 'securerandom'

# Wrapper object for documents

module Cushion
  class Doc
    attr_reader :id, :rev, :keys
    def initialize(id = nil, source = {})
      @source = source
      @id = source['_id'] || SecureRandom.uuid.gsub(/-/, "")
      @rev = source['_rev'] || 0
      @keys = []
      source.keys.select {|i| /^[^_].*$/.match(i)}.each { |h| bless h }
    end

    def merge(h)
      @source.merge(h)
      h.keys.each do | elem |
        bless(elem)
        @keys.push(elem)
      end
    end

    private
    def bless(k) # Dude, your perl is showing!
      define_method(k.intern) do | arg |
        if arg then
          @source[k] = arg
        else
          @source[k]
        end
      end
    end
  end
end
