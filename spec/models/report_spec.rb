require 'rails_helper'

RSpec.describe Report, type: :model do

  let!(:live_stream) { LiveStream.create!(title: "Live Stream 1") }
  subject { Report.new(number_accesses: 5, number_messages_sent: 30, live_stream: live_stream) }

  it "should validate presence of number_accesses" do
    subject.number_accesses = nil

    expect(subject).to_not be_valid
  end

  it "should validate presence of number_messages_sent" do
    subject.number_messages_sent = nil

    expect(subject).to_not be_valid
  end

end
