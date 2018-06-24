class Seller < ApplicationRecord
	has_many :lots

	scope :by_code, ->{order(sellercode: :asc)}

	def code_and_name
		"#{sellercode} (#{firstname} #{lastname})"
	end
end
