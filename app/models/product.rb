class Product < ApplicationRecord
	belongs_to :sale
	belongs_to :category
	belongs_to :seller
	has_one_attached :image
	has_many_attached :pictures	
end
