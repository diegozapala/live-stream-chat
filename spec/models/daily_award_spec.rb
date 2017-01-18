require 'rails_helper'

RSpec.describe DailyAward, type: :model do

  let!(:user) { User.create!(name: "Teste", email: "teste@teste.com.br", password: "testes") }
  subject { DailyAward.new(user: user, number_messages_sent: 5) }

  it "should validate presence of user" do
    subject.user = nil

    expect(subject).to_not be_valid
  end

  it "should validate presence of number_messages_sent" do
    subject.number_messages_sent = nil

    expect(subject).to_not be_valid
  end

end
