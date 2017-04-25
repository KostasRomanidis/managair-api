class AddOrganizationToPurchase < ActiveRecord::Migration[5.0]
  def change
    add_reference :purchases, :organization, foreign_key: true
  end
end
