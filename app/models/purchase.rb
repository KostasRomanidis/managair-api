class Purchase < ApplicationRecord
  belongs_to :organization
  belongs_to :customer
  belongs_to :product

  validates_presence_of :purchase_date
end
