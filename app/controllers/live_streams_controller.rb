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

  def daily_award
    date = Time.now.strftime("%d-%m-%Y")
    chats = Chat.find_date(date: date)

    messages = chats.map{ |key| Chat.messages(key) }.flatten

    user_ids = messages.map { |message| message.split("_")[1] }
    uniq_user_ids = user_ids.uniq

    agroup_user_ids = uniq_user_ids.map{ |uniq_user_id| user_ids.reject{|user_id| user_id!=uniq_user_id } }
    agroup_user_ids = agroup_user_ids.map{ |ag| [ag.count, ag.first] }.to_h
    agroup_user_ids = agroup_user_ids.sort{|k,v| -1*(k<=>v) }.to_h
    agroup_user_ids = agroup_user_ids.to_a[0..2].to_h
    agroup_user_ids.each do |number_messages, user_id|
      user = User.find(user_id)
      DailyAward.create(user: user, number_messages_sent: number_messages)
    end
  end


end
