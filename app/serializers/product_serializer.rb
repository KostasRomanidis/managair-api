class ProductSerializer < ActiveModel::Serializer
  attributes :id, :brand, :model, :cost, :btu
  has_many :customers
  belongs_to :organization
end
