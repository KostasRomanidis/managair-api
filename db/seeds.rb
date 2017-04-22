# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
5.times do
  Customer.create(name: Faker::StarWars.character, phone: Faker::PhoneNumber.phone_number, address: Faker::Address.street_address, customer_type: Faker::Lorem.word)
  Product.create(brand: Faker::Lorem.word, model: Faker::Lorem.word, cost: Faker::Number.number(4), btu: Faker::Number.number(3))
end

customer = Customer.first
product = Product.first
product_2 = Product.second
customer_2 = Customer.second
customer.purchases.create(purchase_date: Faker::Date.backward(2), customer_id: customer.id, product_id: product.id)
customer.purchases.create(purchase_date: Faker::Date.backward(5), customer_id: customer.id, product_id: product_2.id)
customer_2.purchases.create(purchase_date: Faker::Date.backward(3), customer_id: customer_2.id, product_id: product.id)
