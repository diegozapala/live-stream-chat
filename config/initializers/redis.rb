# set redis connection

ENV['REDIS_URL'] ||= (ENV['REDIS_URL'] || 'redis://127.0.0.1:6379')
Redis.new(driver: :hiredis)
