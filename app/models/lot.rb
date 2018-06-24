class Lot < ApplicationRecord
	belongs_to :sale
	belongs_to :category
	belongs_to :seller
	has_many :bids
	has_many :bidders, through: :bids, source: :buyer
	has_one_attached :image
	has_many_attached :pictures	

	scope :by_sale_asc, ->(id){where('sale_id = ?', id).order(lotnumber: :asc)}

end
