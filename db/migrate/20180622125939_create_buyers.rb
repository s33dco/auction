class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.decimal :commrate

      t.timestamps
    end
  end
end
