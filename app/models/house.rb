class House < ApplicationRecord
	has_many :sales
	has_one_attached :banner

	scope :alpha, ->{order(name: :asc)}
end
