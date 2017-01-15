module ApplicationHelper

  def send_cable(message)
    html = render_message(message)
    ActionCable.server.broadcast 'messages',
      html: html
  end

  def render_message(message)
    ApplicationController.render({
      partial: 'live_streams/message',
      locals: { messages: message }
    })
  end

end
