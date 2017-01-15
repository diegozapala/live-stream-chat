class Chat

  KEY_PARSER = /chat_(?<live_stream_id>[0-9]+)_(?<user_id>[0-9]+)/

  attr_reader :live_stream, :user

  def self.find_all(*keys)
    keys.flatten!
    keys.reduce([]) { |acc, elem| acc << find(elem) }.compact
  end

  def self.all
    find_all(keys)
  end

  def self.find(key)
    live_stream_id, user_id = parse_key(key)

    live_stream = LiveStream.find_by(id: live_stream_id)
    user        = User.find_by(id: user_id)

    return if user.nil? || live_stream.nil?

    new(live_stream: live_stream, user: user)
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

  def initialize(live_stream:, user:)
    @live_stream = live_stream
    @user = user
  end

  def key
    "chat_#{live_stream.id}_#{user.id}"
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

  def message(date:)
    redis_db.hget(key, date)
  end

  def add(date:, message:)
    redis_db.hset(key, date, message)
  end

  def destroy!
    redis_db.del(key)
  end

  private

  def redis_db
    self.class.redis_db
  end
end
