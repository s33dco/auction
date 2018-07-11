class Seller < ApplicationRecord
	has_many :lots

	scope :by_code, ->{order(code: :asc)}

	def full_name
		"#{firstname} #{lastname}"
	end

	def code_and_name
		"#{code} (#{firstname} #{lastname})"
	end
end
