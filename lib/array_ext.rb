class Array
  def self.insist(thing)
    Array === thing ? thing : [thing]
  end
end
