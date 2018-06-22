class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :house, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
