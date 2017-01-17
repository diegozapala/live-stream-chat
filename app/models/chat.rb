class Chat

  attr_reader :live_stream, :key_date

  def self.redis_db
    Redis.current
  end

  def self.keys
    redis_db.keys("chat_*")
  end

  def self.find_by_date(date:)
    keys.select{ |k| k.split("_").include?(date) }
  end

  def self.messages(chat_key)
    redis_db.hkeys(chat_key).select{ |k| k.include?("message") }
  end

  def initialize(live_stream:, date: nil)
    @live_stream = live_stream
    @key_date = date || live_stream.created_at.strftime("%d-%m-%Y_%H:%M:%S")
  end

  def key
    "chat_#{live_stream.id}_#{key_date}"
  end

  def all_messages
    redis_db.hgetall(key).select{ |k,_| k.include?("message") }
  end

  def all_access
    redis_db.hgetall(key).select{ |k,_| k.include?("access") }
  end

  def total_messages
    all_messages.count
  end

  def number_accesses
    all_access.values.uniq.count
  end

  def add_message(user:, date:, message:)
    redis_db.hset(key, "message_#{user.id}_#{date}", message)
  end

  def add_access(user:, date:)
    redis_db.hset(key, "access_#{date}", user.id)
  end

  private

  def redis_db
    self.class.redis_db
  end

end
