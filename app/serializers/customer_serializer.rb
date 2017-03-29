class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :address, :customer_type
end
