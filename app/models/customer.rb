class Customer < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :customer_type
  validates_presence_of :address
  validates_presence_of :phone
end
