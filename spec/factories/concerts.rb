FactoryGirl.define do
  word = Faker::Lorem.word
  factory :concert do
    address_1 RandomData.random_address
    city "Naperville"
    state "IL"
    title word
    show_date Faker::Date.forward(30)
    show_time Time.now
    location_name word
  end
end
