class CreateLots < ActiveRecord::Migration[5.2]
  def change
    create_table :lots do |t|
      t.string :manufacturer
      t.string :model
      t.string :description
      t.integer :lotnumber
      t.decimal :sellingprice
      t.decimal :reserve
      t.timestamps
    end
  end
end
