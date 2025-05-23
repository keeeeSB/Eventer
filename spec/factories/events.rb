FactoryBot.define do
  factory :event do
    title { "花火大会" }
    description { "花火大会を開催します。" }
    start_time { "2025-07-07" }
    location { "河川敷" }
    association :user
    association :category
  end
end
