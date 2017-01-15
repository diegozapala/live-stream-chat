require 'rails_helper'

RSpec.describe LiveStream, type: :model do

  subject { LiveStream.new(title: "Teste", description: "teste teste teste") }

  it "should validate presence of title" do
    subject.title = nil

    expect(subject).to_not be_valid
  end

  it "should validate uniqueness of title" do
    LiveStream.create!(title: "Teste")

    expect(subject).to_not be_valid
  end

end
