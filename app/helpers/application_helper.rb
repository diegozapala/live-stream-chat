module ApplicationHelper

  def send_cable(messages)
    html = render_message(messages)
    ActionCable.server.broadcast 'messages',
      html: html
  end

  def render_message(messages)
    ApplicationController.render({
      partial: 'live_streams/message',
      locals: { messages: messages }
    })
  end

  def message_user(key_message)
    user_id = key_message.split("_").last
    User.find_by(id: user_id)
  end

end
