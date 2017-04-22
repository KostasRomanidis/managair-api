class Product < ApplicationRecord
  has_many :purchases
  has_many :customers, through: :purchases
  belongs_to :organization

  validates_presence_of :brand
  validates_presence_of :model
  validates_presence_of :cost
  validates_presence_of :btu
end
