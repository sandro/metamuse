module Arrayish
  # List of array methods (that are not in +Object+) that need to be
  # delegated to +collection+.
  ARRAY_METHODS = (Array.instance_methods - Object.instance_methods).map { |n| n.to_s }

  # List of additional methods that must be delegated to +collection+.
  MUST_DEFINE = %w[to_a to_ary inspect]

  (ARRAY_METHODS + MUST_DEFINE).uniq.each do |method|
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{method}(*args, &block)                 # def each(*args, &block)
        collection.send(:#{method}, *args, &block)  #   collection.send(:each, *args, &block)
      end                                          # end
    RUBY
  end

  # Lie about our class. Borrowed from Rake::FileList
  # Note: Does not work for case equality (<tt>===</tt>)
  def is_a?(klass)
    klass == Array || super(klass)
  end
  alias kind_of? is_a?
end
