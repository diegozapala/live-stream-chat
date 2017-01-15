require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.new(email: "teste@teste.com.br", password: "testes") }

  it "should validate presence of email" do
    subject.email = nil

    expect(subject).to_not be_valid
  end

  it "should validate presence of password" do
    subject.password = nil

    expect(subject).to_not be_valid
  end

  it "should validate uniqueness of email" do
    User.create!(email: "teste@teste.com.br", password: "testes")

    expect(subject).to_not be_valid
  end

  it "should validate a valid email" do
    subject.email = "teste"

    expect(subject).to_not be_valid
  end

end
