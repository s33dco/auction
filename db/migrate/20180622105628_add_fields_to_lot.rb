class AddFieldsToLot < ActiveRecord::Migration[5.2]
  def change
    add_reference :lots, :sale, foreign_key: true
    add_reference :lots, :seller, foreign_key: true
    add_reference :lots, :category, foreign_key: true
  end
end
