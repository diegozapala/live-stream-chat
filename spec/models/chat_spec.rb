require 'rails_helper'

RSpec.describe Chat, type: :model do

  let!(:user) { User.create!(name: "Teste", email: "teste@teste.com.br", password: "testes") }
  let!(:live_stream) { LiveStream.create!(title: "Live Stream 1") }

  let!(:chat) { Chat.new(live_stream: live_stream) }
  let!(:key_date) { live_stream.created_at.strftime("%d-%m-%Y_%H:%M:%S") }
#  let!(:message_date) { Time.now.strftime("%d-%m-%Y_%H:%M:%S") }
  let!(:key)  { "chat_#{live_stream.id}_#{key_date}" }

  it "should validate key" do
    expect(chat.key).to eq(key)
  end

  it "should add a new message in chat" do
    add = chat.add_message(user: user, message: "teste")

    expect(add).to be_truthy
  end

  it "should add a new accesses in chat" do
    add = chat.add_access(user: user)

    expect(add).to be_truthy
  end

  it "should show the total messages by chat" do
    chat.add_message(user: user, message: "teste")

    expect(chat.total_messages).to eq(1)
  end

  it "should show the total access by chat" do
    chat.add_access(user: user)

    expect(chat.number_accesses).to eq(1)
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
