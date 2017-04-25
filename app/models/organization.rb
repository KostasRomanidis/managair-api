class Organization < ApplicationRecord
  validates_presence_of :name
  has_many :purchases
  has_many :customers
  has_many :products
end
