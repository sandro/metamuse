class Hash
  def replace_key(old_key, key)
    dup.replace_key! old_key, key
  end

  def replace_key!(old_key, key)
    store(key, delete(old_key))
    self
  end

  def replace_keys(replacements={})
    dup.replace_keys! replacements
  end

  def replace_keys!(replacements={})
    replacements.each do |old_key, key|
      replace_key!(old_key, key)
    end
    self
  end
end
