module Metamuse
  module Association
    def self.extended(base)
      class << base
        attr_accessor :has_many_set, :belongs_to_set
      end
      base.belongs_to_set = base.has_many_set = {}
      base.send :include, InstanceMethods
    end

    def has_many(accessor, klass)
      has_many_set.merge! klass => accessor

      define_method(accessor) do
        ivar = "@#{accessor}"
        if val = instance_variable_get(ivar)
          val
        else
          instance_variable_set(ivar, Collection.new(self, klass))
        end
      end

      define_method("#{accessor}=") do |items|
        send(accessor).clear
        send(accessor) << items
      end
    end

    def belongs_to(accessor, klass)
      belongs_to_set.merge! klass => accessor

      define_method(accessor) do
        instance_variable_get(:"@#{accessor}")
      end

      define_method(:"#{accessor}=") do |parent|
        instance_variable_set(:"@#{accessor}", parent)
      end
    end

    module InstanceMethods
      def belongs(owner)
        accessor = self.class.belongs_to_set[owner.class]
        send("#{accessor}=", owner) if accessor
      end
    end
  end
end
