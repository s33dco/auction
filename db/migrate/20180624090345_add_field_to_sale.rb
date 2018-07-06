class AddFieldToSale < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :active, :boolean, default: false
    add_column :sales, :complete, :boolean, default: false
  end
end
