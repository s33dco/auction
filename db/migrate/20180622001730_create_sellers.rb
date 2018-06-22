class CreateSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :sellers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.decimal :commrate

      t.timestamps
    end
  end
end
