class Cache

  EXPIRATION_LIMIT = 3600

  def initialize()
    @expirations = {}
    @cache_memory = {}
  end

  def read(file_name)
    return false if @cache_memory[file_name.to_sym].nil?

    @cache_memory[file_name.to_sym]
  end

  def write(file_name, content)
    @expirations[file_name.to_sym] = Time.now.to_i
    @cache_memory[file_name.to_sym] = content
  end

  def expired?(file_name)
    return true if @expirations[file_name.to_sym].nil?

    Time.now.to_i - EXPIRATION_LIMIT > @expirations[file_name.to_sym]
  end

end