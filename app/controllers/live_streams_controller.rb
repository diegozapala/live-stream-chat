class LiveStreamsController < ApplicationController
  include ApplicationHelper

  def index
    @live_streams = LiveStream.all
  end

  def show
    @live_stream = LiveStream.find_by(id: params[:id])
    @messages = current_chat.all_messages
  end

  def add_chat_message
    date = Time.now.strftime("%d-%m-%Y %H:%M:%S")
    current_chat.add(user: current_user, date: date, message: params[:message])

    @messages = [{date => params[:message]}]

    send_cable(@messages)
    redirect_to live_stream_path(current_live_stream)
  end

  private

  def current_live_stream
    @live_stream || LiveStream.find(params[:live_stream_id])
  end

  def current_chat
    Chat.new(live_stream: current_live_stream)
  end

end
