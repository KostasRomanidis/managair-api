FactoryGirl.define do
  factory :customer do
    name { Faker::StarWars.character }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    customer_type { Faker::Lorem.word }
  end
end
