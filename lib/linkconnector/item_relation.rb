module Linkconnector
  class ItemRelation
    DEFAULTCOUNT = 10

    attr_accessor :findOptions

    def initialize(options)
      self.findOptions = options
    end

    # Finishers
    def all
      execute
    end

    def count
      execute.size
    end

    # Chains
    def search(term)
      self.findOptions[:search] = term
      self
    end

    def order(term)
      self.findOptions[:sort] = term
      self
    end

    def limit(num)
      self.findOptions[:count] = num
      self
    end

    def merchant(id)
      self.findOptions[:merchants] = [id]
    end

    def page(num)
      self.findOptions[:page] = num
      self
    end

    def type(term)
      self.findOptions[:type] = term
      self
    end

    private

    def execute
      @lastResponse = client.post("/api/", queryParams)
      if @lastResponse.status == 200
        JSON.parse(@lastResponse.body)
      else
        raise "There was an error #{@lastResponse.body}"
      end
    end

    def queryParams
      {
        KeywordSearch: self.findOptions[:search],
        Function: 'getFeedProductSearch',
        Format: 'JSON',
        ProductType: self.findOptions[:type] || "vector",
        RowsPerCall: self.findOptions[:count] || DEFAULTCOUNT,
        ImageSizePreference: 'Thumb',
        SortField: self.findOptions[:sort] || "EPC",
        SortDirection: 'DESC',
        RowStart: (self.findOptions[:page] || 0) * (self.findOptions[:count] || DEFAULTCOUNT),
        MerchantIDs: self.findOptions[:merchants].join(",")
      }
    end

    def client
      @client ||= Client.new(
        api_key: Linkconnector.config[:api_key]
      )
    end
  end
end