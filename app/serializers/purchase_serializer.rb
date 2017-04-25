class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :purchase_date
  belongs_to :organization
  belongs_to :customer
  belongs_to :product
end
