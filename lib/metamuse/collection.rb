class Metamuse
  class Collection
    include ::Arrayish
    attr_reader :collection, :collection_class, :owner

    def initialize(owner, collection_class)
      @owner = owner
      @collection_class = collection_class
      @collection = []
    end

    alias_method :append, :<<
    alias_method :push, :<<
    alias_method :concat, :<<

    def <<(items)
      Array.insist(items).each do |item|
        item = collection_class.new(item) unless collection_class === item
        append item
        item.belongs owner
      end
      self
    end
  end
end
