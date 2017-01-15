class Chat

  KEY_PARSER = /chat_(?<live_stream_id>[0-9]+)/

  attr_reader :live_stream

  def self.find_all(*keys)
    keys.flatten!
    keys.reduce([]) { |acc, elem| acc << find(elem) }.compact
  end

  def self.all
    find_all(keys)
  end

  def self.find(key)
    live_stream_id = parse_key(key)

    live_stream = LiveStream.find_by(id: live_stream_id)

    return if live_stream.nil?

    new(live_stream: live_stream)
  end

  def self.redis_db
    Redis.current
  end

  def self.parse_key(key)
    parsed_ids = KEY_PARSER.match(key)
    parsed_ids&.captures
  end

  def self.keys
    redis_db.keys("chat_*")
  end

  def initialize(live_stream:)
    @live_stream = live_stream
  end

  def key
    "chat_#{live_stream.id}"
  end

  def persisted?
    redis_db.exists(key)
  end

  def all_messages
    redis_db.hgetall(key)
  end

  def total_messages
    redis_db.hkeys(key).count
  end

  def message(user:, date:)
    redis_db.hget(key, "#{user.id}_#{date}")
  end

  def add(user:, date:, message:)
    redis_db.hset(key, "#{user.id}_#{date}", message)
  end

  def destroy!
    redis_db.del(key)
  end

  private

  def redis_db
    self.class.redis_db
  end
end
