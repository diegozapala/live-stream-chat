class LiveStreamsController < ApplicationController
  include ApplicationHelper

  def index
    @live_streams = LiveStream.all
  end

  def show
    @live_stream = LiveStream.find(params[:id])
    @messages = current_chat.all_messages

    current_chat.add_access(user: current_user, date: formatted_date)
  end

  def add_chat_message
    date = formatted_date
    current_chat.add_message(user: current_user, date: date, message: params[:message])

    @messages = [{date => params[:message]}]

    send_cable(@messages)
    redirect_to live_stream_path(current_live_stream)
  end

  private

  def formatted_date
    Time.now.strftime("%d-%m-%Y %H:%M:%S")
  end

end
