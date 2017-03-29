FactoryGirl.define do
  factory :product do
    brand { Faker::Lorem.word }
    model { Faker::Lorem.word }
    cost { Faker::Number.number(4) }
    btu { Faker::Number.number(3) }
  end
end
