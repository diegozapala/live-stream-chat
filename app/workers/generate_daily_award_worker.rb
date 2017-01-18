class GenerateDailyAwardWorker
  include Sidekiq::Worker

  sidekiq_options queue: :critical

  def perform
    puts "Iniciou"
    days_chat_keys = find_days_chat_keys

    all_messages = get_all_messages(days_chat_keys)

    user_ids = get_only_user_id(all_messages)

    user_ids_per_group = group_by_id(user_ids)

    user_ids_hash = count_elements_and_parse_to_hash(user_ids_per_group)

    user_ids_hash_ordered = sort_hash_by_key(user_ids_hash)

    winner_users = select_range_hash(user_ids_hash_ordered, 3)

    build_daily_awards(winner_users)
    puts "Terminou"
  end

  private

  def find_days_chat_keys
    date = Time.now.strftime("%d-%m-%Y")
    Chat.find_by_date(date: date)
  end

  def get_all_messages(keys)
    keys.map{ |chat_key| Chat.messages(chat_key) }.flatten
  end

  def get_only_user_id(message_kyes)
    message_kyes.map { |message| message.split("_").last }
  end

  def group_by_id(user_ids)
    uniq_user_ids = user_ids.uniq

    uniq_user_ids.map do |uniq_user_id|
      user_ids.select{|user_id| user_id==uniq_user_id }
    end
  end

  def count_elements_and_parse_to_hash(array_group)
    array_group.map{ |ag| [ag.count, ag.first] }.to_h
  end

  def sort_hash_by_key(hash_group)
    hash_group.sort{|k,v| -1*(k<=>v) }.to_h
  end

  def select_range_hash(hash_group, quantity)
    hash_group.to_a[0..quantity-1].to_h
  end

  def build_daily_awards(winner_users)
    winner_users.each do |number_messages, user_id|
      create_daily_awards(user_id, number_messages)
    end
  end

  def create_daily_awards(user_id, number_messages)
    user = User.find(user_id)
    DailyAward.create!(user: user, number_messages_sent: number_messages)
  end

end
