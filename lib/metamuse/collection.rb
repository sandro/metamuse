class Metamuse
  module Collection
    def has_many(accessor, klass)
      collection = []
      collection.instance_variable_set(:@collection_class, klass)
      class << collection
        alias_method :append, :<<
        alias_method :push, :<<
        alias_method :concat, :<<

        def <<(items)
          items = (Array === items) ? items : [items]
          items.each do |item|
            if @collection_class === item
              append item
            else
              append @collection_class.new(item)
            end
          end
          self
        end
      end

      define_method(accessor) do
        @collection ||= collection
      end

      define_method(:"#{accessor}=") do |items|
        collection << items
      end
    end

    def belongs_to(accessor, klass)
      define_method(accessor) do
        instance_variable_get(:"@#{accessor}")
      end

      define_method(:"#{accessor}=") do |parent|
        instance_variable_set(:"@#{accessor}", parent)
      end
    end
  end
end
