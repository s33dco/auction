class AddFieldToReport < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :category, foreign_key: true
  end
end
