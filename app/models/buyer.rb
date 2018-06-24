class Buyer < ApplicationRecord
	has_many :bids
	has_many :bidon, through: :bids, source: :lot

	scope :by_code, ->{order(buyercode: :asc)}

	def code_and_name
		"#{buyercode} (#{firstname} #{lastname})"
	end
end
