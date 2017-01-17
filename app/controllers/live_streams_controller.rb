class LiveStreamsController < ApplicationController
  include ApplicationHelper

  def index
    @live_streams = LiveStream.all
  end

  def show
    @live_stream = LiveStream.find(params[:id])
    @messages = current_chat.all_messages

    current_chat.add_access(user: current_user)
  end

  def add_chat_message
    message = current_chat.add_message(user: current_user, message: params[:message])

    @messages = [params[:message]]

    send_cable(@messages)
    redirect_to live_stream_path(current_live_stream)
  end
end
