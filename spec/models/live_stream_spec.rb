require 'rails_helper'

RSpec.describe LiveStream, type: :model do

  subject { LiveStream.new(description: "teste teste teste") }

  it "should validate presence of title" do
    expect(subject).to_not be_valid
  end

end
