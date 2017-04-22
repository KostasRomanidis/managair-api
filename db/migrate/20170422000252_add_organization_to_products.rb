class AddOrganizationToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :organization, foreign_key: true
  end
end
