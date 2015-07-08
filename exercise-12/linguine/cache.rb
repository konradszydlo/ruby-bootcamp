class Cache

  def initialize(cache = {})
    @cache = cache
  end

  def add(key, value)
    @cache[key] = value
  end

  def remove(key)
    @cache[key] = nil
  end

  def is_cached(key)
    !@cache[key].nil?
  end

  def get_cached_value(key)
    @cache[key]
  end
end