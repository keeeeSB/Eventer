FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    confirmed_at { Time.current }
  end
end
