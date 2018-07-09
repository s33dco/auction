class AddFieldToHouse < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :siteinfo, :boolean, default: false
  end
end
