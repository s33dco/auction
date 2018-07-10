class Lot < ApplicationRecord
	belongs_to :sale
	belongs_to :category
	belongs_to :seller
	has_many :reports # is this right ?
	has_many :bids
	has_many :bidders, through: :bids, source: :buyer
	has_one_attached :image
	has_many_attached :pictures	

	scope :by_lot_number, ->{order(lotnumber: :asc)}
	scope :asc_by_sale, ->(id){where('sale_id = ?', id).order(lotnumber: :asc)}
	scope :by_category, ->(id){by_lot_number.joins(:category).merge(Category.where('category_id = ?',id))}
	scope :complete, ->{joins(:sale).where('complete = ?', true )}
	scope :active, ->{joins(:sale).where('active = ?', true )}
	# todo need to add attribute to model
	scope :unsold, ->{}

	def make_and_model
		"#{manufacturer} #{model}"
	end

	def sellingfee
		if selling_price == 0
			0
		else
			sale.minfee >= selling_price ? sale.minfee : ((selling_price/100) * seller.commrate)
		end 
	end

	def buyingfee
		if selling_price == 0
			0
		else
			sale.minfee >= selling_price ? sale.minfee : ((selling_price/100) * highest_bid.buyer.commrate)
		end
	end

	def commissions
		sellingfee + buyingfee	
	end

	def buyer_highest_bid(buyer)
		bids.where("buyer_id = ?", buyer).order(bidvalue: :desc).first
	end
	
	def highest_bid
		bids.order(bidvalue: :desc).first		
	end

	def second_best_bid
		# the highest bid from a different buyer
		bids.where.not(buyer_id: highest_bid.buyer.id).order(bidvalue: :desc).first		
	end

	def selling_price
		if self.bids.empty?
			# if no bids.....
			0
		else
			if self.second_best_bid
				# selling price is second bid from different buyer plus notch if there is a 2nd bid
				(self.sale.notch + self.second_best_bid.bidvalue)
			else
				if self.highest_bid.bidvalue >= self.reserve
					# else if highest bid is equal or greater then reserve add notch to reserve
					(self.sale.notch + self.reserve)
				else
					# else add notch to highest bid as less than reserve
					(self.sale.notch + self.highest_bid.bidvalue)
				end
			end
		end
	end
end
