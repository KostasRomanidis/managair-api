class Product < ApplicationRecord
  validates_presence_of :brand
  validates_presence_of :model
  validates_presence_of :cost
  validates_presence_of :btu
end
