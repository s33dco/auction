class CreateBuyersHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers_houses do |t|
      t.references :buyer, foreign_key: true
      t.references :house, foreign_key: true

      t.timestamps
    end
  end
end
