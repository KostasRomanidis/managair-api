class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :purchase_date, :customer_id, :product_id
  belongs_to :customer
end
