class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  mount_uploader :profile_image, ProfileImageUploader

  has_many :events, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :review_events, through: :reviews, source: :event

  validates :name, presence: true
  validates :bio, length: { maximum: 50 }
end
