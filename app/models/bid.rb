class Bid < ApplicationRecord
  belongs_to :buyer
  belongs_to :lot
  belongs_to :sale

  validates :buyer_id, :lot_id, :bidvalue, presence: true
  validates_uniqueness_of :bidvalue, :scope => [:lot_id]
  validate :bid_enough


  scope :desc_order, ->{order(bidvalue: :desc)}
  scope :leading_bids, ->(number=5){desc_order.limit(number)}
  scope :eldest_first, ->{order(created_at: :asc)}
 

 	private 

 	def bid_enough
 		if bidvalue < lot.selling_price 
 			errors.add(:bidvalue, "too low")
 		end
 	end

end
