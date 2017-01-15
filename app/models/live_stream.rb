class LiveStream < ApplicationRecord
  has_one :report

  validates :title,  presence: true, uniqueness: true

end
