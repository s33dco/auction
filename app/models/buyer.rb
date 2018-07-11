class Buyer < ApplicationRecord
	has_many :bids
	has_many :bidon, through: :bids, source: :lot

	scope :by_code, ->{order(buyercode: :asc)}

	def bid_for(lot)
		bids.where('lot_id = ?', lot)
	end

	def full_name
		"#{firstname} #{lastname}"
	end

	def code_and_name
		"#{code} (#{firstname} #{lastname})"
	end
end
