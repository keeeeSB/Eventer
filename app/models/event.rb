class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :category, reject_if: :category_blank?

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

  private

    def category_blank?(attributes)
      attributes["name"].blank?
    end
end
