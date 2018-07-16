class ABuyerFieldToLots < ActiveRecord::Migration[5.2]
  def change
  	add_reference :lots, :buyer, foreign_key: true
  end
end
