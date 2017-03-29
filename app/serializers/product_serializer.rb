class ProductSerializer < ActiveModel::Serializer
  attributes :id, :brand, :model, :cost, :btu
end
