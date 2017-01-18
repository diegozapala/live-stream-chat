class ChatsController < ApplicationController
  include ApplicationHelper

  def add_chat_message
    @message = current_chat.add_message(user: current_user, message: params[:message])
    @user = current_user
    send_cable(@message)

    redirect_back(fallback_location: live_stream_path(current_live_stream))
  end
end
