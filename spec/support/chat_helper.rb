module ChatHelper
  def add_message_to_chat(chat, user)
    chat.add_message(user: user, date: formatted_date, message: "teste")
  end

  private

  def formatted_date
    (Time.now+1).strftime("%d-%m-%Y_%H:%M:%S")
  end
end
