class Lot < ApplicationRecord
	belongs_to :sale
	belongs_to :category
	belongs_to :seller
	has_many :bids
	has_many :bidders, through: :bids, source: :buyer
	has_one_attached :image
	has_many_attached :pictures	
	scope :by_lot_number, ->{order(lotnumber: :asc)}
	scope :auctioned, ->{where(sold: [true,false])}
	scope :unsold, ->{where(sold: false)}
	scope :sold, ->{where(sold: true)}
	# scope :buyerowes, ->{where(buyerpaid: false)}
	# scope :buyerpaid, ->{where(buyerpaid: true)}
	# scope :sellerowed, ->{where(sellerpaid:false)}
	# scope :sellerpaid, ->{where(sellerpaid: true)}
	# scope :buyerunpaid, ->(buyer){}	

	def self.total_sales
		sum{|l| l.soldat}
	end

	def self.total_buyer_fees
		sum{|l| l.bfee}
	end

	def self.total_seller_fees
		sum{|l| l.sfee}
	end

	def self.total_comm
		total_buyer_fees + total_seller_fees
	end

	def self.total_gross
		total_sales + total_buyer_fees
	end

	def self.pay_out
		total_sales - total_seller_fees
	end

	def self.average_profit
		if self.count == 0 
			0
		else
			total_comm / self.count
		end
	end


	def self.to_csv
		CSV.generate do |csv|
			csv << ["Date", "Sale", "Lot#", "Lot_id", "Item", "Reserve  (£)", "Sold", "Highest bid  (£)", "Selling Price  (£)", "Profit (£)", "Winner", "Buyer Fee (£)", "Buyer Paid", "Seller", "Seller Fee (£)", "Seller Paid"]
			all.each do |lot|
					row = [lot.sale.date, lot.sale.house.code, lot.lotnumber, lot.id, lot.make_and_model, lot.reserve, lot.sold, lot.highest_bid_value, lot.soldat, lot.commissions, lot.winner, lot.bfee, lot.buyerpaid, lot.seller.full_name, lot.sfee, lot.sellerpaid ]
					csv << row
			end
		end
	end

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
		if sold?
			bfee + sfee	
		else
			0
		end
	end

	def buyer_highest_bid(buyer)
		bids.where("buyer_id = ?", buyer).order(bidvalue: :desc).first
	end
	
	def highest_bid
		bids.order(bidvalue: :desc)	
	end

	def highest_bid_value
		if highest_bid.empty?
			0
		else
			highest_bid.first.bidvalue
		end
	end

	# def buyer_name
	# 	if highest_bid_value > reserve
	# 		highest_bid.buyer.full_name
	# 	else
	# 		"no sale"
	# 	end
	# end

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
				if self.highest_bid_value >= self.reserve
					# else if highest bid is equal or greater then reserve add notch to reserve
					(self.sale.notch + self.reserve)
				else
					# else add notch to highest bid as less than reserve
					(self.sale.notch + self.highest_bid_value)
				end
			end
		end
	end
end
