class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :body, presence: true, length: { maximum: 100 }
  validates :star_rating, presence: true
end
