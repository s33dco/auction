class House < ApplicationRecord
	has_many :sales

	scope :alpha, ->{order(name: :asc)}
end
