class Report < ApplicationRecord
  belongs_to :live_stream

  validates :number_accesses,  presence: true
  validates :number_messages_sent,  presence: true
end
