FactoryBot.define do
  factory :recipe do
    sequence(:name) { |i| "recipe#{i}" }
    text { Faker::Food.description }
    recent_at { '2022-06-03' }
    user
  end
end
