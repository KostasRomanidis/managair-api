FactoryGirl.define do
  factory :purchase do
    purchase_date { Faker::Date.backward(5) }
    organization
    customer
    product
  end
end
