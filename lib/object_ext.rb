class Object
  def tap
    yield self
    self
  end

  def try(method, *args)
    send(method, *args) if respond_to? method
  end

  def attempt
    yield self
    rescue StandardError, RuntimeError
      self
  end
end
