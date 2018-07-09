class House < ApplicationRecord
	has_many :sales
	has_one_attached :banner

	scope :home, ->{where("siteinfo = ?", true)}
	scope :alpha, ->{order(name: :asc)}
end
