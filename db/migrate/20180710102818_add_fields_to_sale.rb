class AddFieldsToSale < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :notch, :decimal, default: 3.00
    add_column :sales, :minfee, :decimal, default: 3.50
  end
end
