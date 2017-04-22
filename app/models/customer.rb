class Customer < ApplicationRecord
  has_many :purchases
  has_many :products, through: :purchases
  belongs_to :organization

  validates_presence_of :name
  validates_presence_of :customer_type
  validates_presence_of :address
  validates_presence_of :phone
end
