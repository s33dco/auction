class CreateLots < ActiveRecord::Migration[5.2]
  def change
    create_table :lots do |t|
      t.string :manufacturer
      t.string :model
      t.string :description
      t.integer :lotnumber
      t.decimal :sellingprice, :decimal, precision: 7, scale: 2
      t.decimal :reserve, :decimal, precision: 7, scale: 2
      t.timestamps
    end
  end
end
