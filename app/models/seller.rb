class Seller < ApplicationRecord
	has_many :lots
	has_many :reports

	scope :by_code, ->{order(code: :asc)}

	def code_and_name
		"#{code} (#{firstname} #{lastname})"
	end
end
