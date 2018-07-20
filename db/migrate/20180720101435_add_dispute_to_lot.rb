class AddDisputeToLot < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :dispute, :boolean, default: false
  end
end
