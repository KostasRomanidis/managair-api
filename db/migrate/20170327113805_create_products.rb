class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :brand
      t.string :model
      t.integer :btu
      t.integer :cost

      t.timestamps
    end
  end
end
