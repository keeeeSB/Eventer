class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  mount_uploader :profile_image, ProfileImageUploader

  validates :name, presence: true
  validates :bio, length: { maximum: 50 }
end
