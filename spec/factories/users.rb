FactoryBot.define do
  factory :user do
    email { 'test_user@example.com' }
    password { 'password' }
    name { 'testuser01' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
  end
end
