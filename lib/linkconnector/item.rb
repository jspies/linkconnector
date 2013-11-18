module Linkconnector
  class Item

    def self.search(term)
      ItemRelation.new(search: term)
    end

    def self.merchant(id)
      ItemRelation.new(merchants: [id])
    end

    def self.order(ostring)
      ItemRelation.new(sort: ostring)
    end

    def self.limit(num)
      ItemRelation.new(limit: num)
    end

    def self.page(num)
      ItemRelation.new(page: num)
    end

    def self.type(t)
      ItemRelation.new(type: t)
    end
    
  end
end