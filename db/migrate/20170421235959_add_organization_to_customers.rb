class AddOrganizationToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_reference :customers, :organization, foreign_key: true
  end
end
