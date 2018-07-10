class AddCodeFieldToHouse < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :code, :string
  end
end
