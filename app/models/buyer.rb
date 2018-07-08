class Buyer < ApplicationRecord
	has_many :bids
	has_many :bidon, through: :bids, source: :lot
	has_many :reports

	scope :by_code, ->{order(buyercode: :asc)}

	def code_and_name
		"#{code} (#{firstname} #{lastname})"
	end
end
