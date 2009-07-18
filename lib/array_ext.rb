class Array
  def self.insist(thing)
    thing.is_a?(Array) ? thing : [thing]
  end
end
