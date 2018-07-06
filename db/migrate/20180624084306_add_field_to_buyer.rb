class AddFieldToBuyer < ActiveRecord::Migration[5.2]
  def change
    add_column :buyers, :code, :string
  end
end
