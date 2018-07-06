class AddFieldToSeller < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :code, :string
  end
end
