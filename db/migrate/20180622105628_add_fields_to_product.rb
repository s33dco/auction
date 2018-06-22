class AddFieldsToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :lotnumber, :integer
    add_reference :products, :sale, foreign_key: true
    add_reference :products, :seller, foreign_key: true
    add_reference :products, :category, foreign_key: true
  end
end
