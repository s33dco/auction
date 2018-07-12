class AddSaleFieldToBids < ActiveRecord::Migration[5.2]
  def change
    add_reference :bids, :sale, foreign_key: true
  end
end
