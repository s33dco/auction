class Lot < ApplicationRecord
	belongs_to :sale
	belongs_to :category
	belongs_to :seller
	has_many :bids
	has_many :bidders, through: :bids, source: :buyer
	has_one_attached :image
	has_many_attached :pictures	

	scope :by_lot_number, ->{order(lotnumber: :asc)}
	scope :asc_by_sale, ->(id){where('sale_id = ?', id).order(lotnumber: :asc)}
	scope :by_category, ->(id){by_lot_number.joins(:category).merge(Category.where('category_id = ?',id))}

end
