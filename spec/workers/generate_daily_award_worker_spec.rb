require 'rails_helper'

RSpec.describe GenerateDailyAwardWorker, type: :worker do

  let!(:user_1) { User.create!(email: "teste@teste.com.br", password: "testes") }
  let!(:user_2) { User.create!(email: "teste2@teste.com.br", password: "testes") }
  let!(:user_3) { User.create!(email: "teste3@teste.com.br", password: "testes") }
  let!(:user_4) { User.create!(email: "teste4@teste.com.br", password: "testes") }

  let!(:live_stream) { LiveStream.create!(title: "Live Stream 1") }
  let!(:chat) { Chat.new(live_stream: live_stream) }

  pending "should select 3 users for daily award" do
    (0..3).each{ |i| add_message_to_chat(chat, user_1) }
    (0..2).each{ |i| add_message_to_chat(chat, user_2) }
    (0..1).each{ |i| add_message_to_chat(chat, user_4) }
    (0..0).each{ |i| add_message_to_chat(chat, user_4) }

    subject.perform

    expect { DailyAward.count }.to eq(3)
  end
end
