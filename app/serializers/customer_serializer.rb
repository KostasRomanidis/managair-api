class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :address, :customer_type
  has_many :products
  belongs_to :organization
end
