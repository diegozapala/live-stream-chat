require 'rails_helper'

RSpec.describe Chat, type: :model do

  let!(:user) { User.create!(email: "teste@teste.com.br", password: "testes") }
  let!(:live_stream) { LiveStream.create!(title: "Live Stream 1") }

  let!(:chat) { Chat.new(live_stream: live_stream) }
  let!(:key_date) { live_stream.created_at.strftime("%d-%m-%Y_%H:%M:%S") }
  let!(:message_date) { Time.now.strftime("%d-%m-%Y_%H:%M:%S") }
  let!(:key)  { "chat_#{live_stream.id}_#{key_date}" }

  pending "have to lookup for an existing chat by date" do
    expect(Chat.find_by_date(date: key_date)).to eq(chat)
  end

  pending "should find all messages by chat key" do
    chat.add_message(user: user, date: message_date, message: "teste")

    expect(Chat.messages(key: key)).to eq({"message_#{user.id}_#{message_date}"=>"teste"})
  end

  it "should validate key" do
    expect(chat.key).to eq(key)
  end

  it "should add a new message in chat" do
    chat.add_message(user: user, date: message_date, message: "teste")

    expect(chat.all_messages).to eq({"message_#{user.id}_#{message_date}"=>"teste"})
  end

  it "should add a new accesses in chat" do
    chat.add_access(user: user, date: message_date)

    expect(chat.all_access).to eq({"access_#{message_date}"=>user.id.to_s})
  end

  it "should show the total messages by chat" do
    chat.add_message(user: user, date: message_date, message: "teste")
    chat.add_message(user: user, date: (Time.now+1).strftime("%d-%m-%Y_%H:%M:%S"), message: "teste2")

    expect(chat.total_messages).to eq(2)
  end

  it "should show the total access by chat" do
    user_b = User.create!(email: "teste_b@teste.com.br", password: "testes")

    chat.add_access(user: user, date: message_date)
    chat.add_access(user: user, date: (Time.now+1).strftime("%d-%m-%Y_%H:%M:%S"))
    chat.add_access(user: user_b, date: (Time.now+2).strftime("%d-%m-%Y_%H:%M:%S"))

    expect(chat.number_accesses).to eq(2)
  end

  it "should require an live stream to instantiate a new object" do
    expect { Chat.new }.to raise_error(ArgumentError)
  end

  it "should have live_stream accessible" do
    expect(chat.live_stream).to be(live_stream)
  end

  it "must receive user, date and message to add a message" do
    expect { chat.add_message }.to raise_error(ArgumentError)
  end

  it "must receive user and date to add a access" do
    expect { chat.add_access }.to raise_error(ArgumentError)
  end




end
