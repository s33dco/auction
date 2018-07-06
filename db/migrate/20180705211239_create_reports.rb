class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :sale, foreign_key: true
      t.references :lot, foreign_key: true
      t.references :seller, foreign_key: true
      t.references :buyer, foreign_key: true
      t.decimal :sold_at
      t.decimal :buyerfee
      t.decimal :sellerfee

      t.timestamps
    end
  end
end
