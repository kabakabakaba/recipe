FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test#{i}@example.com" }
    sequence(:name) { |i| "name#{i}" }
    sequence(:password) { |i| "passtest#{i}" }
    password_confirmation { password }
    confirmed_at { Date.today }
  end
end
