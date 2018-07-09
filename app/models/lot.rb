class Lot < ApplicationRecord
	belongs_to :sale
	belongs_to :category
	belongs_to :seller
	has_many :reports # is this right ?
	has_many :bids
	has_many :bidders, through: :bids, source: :buyer
	has_one_attached :image
	has_many_attached :pictures	
	accepts_nested_attributes_for :bids, allow_destroy: true, reject_if: ->(attrs) { attrs['bidvalue'].blank? || attrs['buyer_id'].blank? }


	scope :by_lot_number, ->{order(lotnumber: :asc)}
	scope :by_reverse_lot_number, ->{order(lotnumber: :desc)}
	scope :asc_by_sale, ->(id){where('sale_id = ?', id).order(lotnumber: :asc)}
	scope :by_category, ->(id){by_lot_number.joins(:category).merge(Category.where('category_id = ?',id))}
	
	def buyer_highest_bid(buyer)
		bids.where("buyer_id = ?", buyer).order(bidvalue: :desc).first
	end
	
	def highest_bid
		bids.order(bidvalue: :desc).first		
	end

	def second_best_bid
		bids.order(bidvalue: :desc).second		
	end

	def selling_price
		if self.second_best_bid
			(3 + self.second_best_bid.bidvalue)
		else
			if self.highest_bid
				(3 + self.reserve)
			else
				(self.reserve)
			end
		end
	end
end
