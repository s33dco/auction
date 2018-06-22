class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :postcode
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
