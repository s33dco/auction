class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :manufacturer
      t.string :model
      t.string :description
      t.decimal :selling_price

      t.timestamps
    end
  end
end
