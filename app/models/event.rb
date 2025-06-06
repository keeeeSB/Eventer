class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, source: :user

  accepts_nested_attributes_for :category, reject_if: :category_blank?

  scope :upcoming, -> { where("start_time >= ?", Time.current).order(start_time: :asc) }
  scope :past,     -> { where("start_time < ?", Time.current).order(start_time: :desc) }

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :start_time, presence: true
  validates :location, presence: true

  def self.build_with_category_handling(user, params)
    if params[:category_id].present?
      user.events.build(params.except(:category_attributes))
    else
      user.events.build(params)
    end
  end

  def finished?
    start_time < Time.current
  end

  private

    def category_blank?(attributes)
      attributes["name"].blank?
    end
end
