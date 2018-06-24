class AddFieldToSale < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :active, :boolean, default: false
  end
end
