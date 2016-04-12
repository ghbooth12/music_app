FactoryGirl.define do
  pw = "password"
  factory :user do
    username Faker::Name.name
    sequence(:email){|n| "user#{n}@factory.com"}
    password pw
    password_confirmation pw
    confirmed_at Date.today
  end
end
