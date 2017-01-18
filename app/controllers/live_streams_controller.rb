class LiveStreamsController < ApplicationController

  def index
    @live_streams = LiveStream.all
  end

  def show
    @live_stream = LiveStream.find(params[:id])
    @messages = current_chat.all_messages.sort{|k,v| -1*(k<=>v) }.to_h
    @user = current_user
    current_chat.add_access(user: current_user)
  end
end
