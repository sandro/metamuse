module Metamuse
  module InstanceInitialize
    def initialize(attrs={})
      attrs.each do |k,v|
        setter = "#{k}="
        if self.class.method_defined? setter
          send setter, v
        else
          instance_variable_set "@#{k}", v
        end
      end
    end

    def attributes
      attrs = {}
      instance_variables.each do |ivar|
        attrs[ivar.sub('@', '').to_sym] = instance_variable_get(ivar)
      end
      attrs
    end
  end
end
