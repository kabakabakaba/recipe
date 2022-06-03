FactoryBot.define do
  factory :recipe do
    name { 'MyString' }
    text { 'MyText' }
    recent_at { '2022-06-03' }
    user
  end
end
