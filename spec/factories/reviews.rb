FactoryBot.define do
  factory :review do
    body { "とても良かったです。" }
    star_rating { "5" }
    association :user
    association :event
  end
end
