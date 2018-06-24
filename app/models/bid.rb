class Bid < ApplicationRecord
  belongs_to :buyer
  belongs_to :lot


  scope :desc_order, ->{order(bidvalue: :desc)}


end
