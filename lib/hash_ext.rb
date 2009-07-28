class Hash
  def rename_key(old_key, key)
    dup.rename_key! old_key, key
  end

  def rename_key!(old_key, key)
    store(key, delete(old_key))
    self
  end

  def rename_keys(replacements={})
    dup.rename_keys! replacements
  end

  def rename_keys!(replacements={})
    replacements.each do |old_key, key|
      rename_key!(old_key, key)
    end
    self
  end
end
