class AddFieldsToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :winner, :integer
    add_column :lots, :soldat, :decimal
    add_column :lots, :bfee, :decimal
    add_column :lots, :sfee, :decimal
    add_column :lots, :sold, :boolean
    add_column :lots, :buyerpaid, :boolean
    add_column :lots, :sellerpaid, :boolean
  end
end
