FactoryGirl.define do
  factory :user do
    name {Faker::StarWars.character}
    email 'skywalker@skywalker.com'
    password 'skywalker'
  end
end
