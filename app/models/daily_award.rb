class DailyAward < ApplicationRecord
  belongs_to :user

  validates :number_messages_sent,  presence: true
end
