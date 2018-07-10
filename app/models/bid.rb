class Bid < ApplicationRecord
  belongs_to :buyer
  belongs_to :lot

  scope :desc_order, ->{order(bidvalue: :desc)}
  scope :leading_bids, ->(number=5){desc_order.limit(number)}
  

end
