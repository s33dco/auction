class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.references :buyer, foreign_key: true
      t.references :lot, foreign_key: true
      t.decimal :bidvalue, precision: 7, scale: 2

      t.timestamps
    end
  end
end
