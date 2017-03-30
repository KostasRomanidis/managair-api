FactoryGirl.define do
  factory :purchase do
    purchase_date { Faker::Date.backward(5) }
    customer
    product
  end
end
