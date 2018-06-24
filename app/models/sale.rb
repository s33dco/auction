class Sale < ApplicationRecord
  belongs_to :house
  has_many :lots
  has_many :vendors, through: :lots, source: :seller
  has_many :bids, through: :lots

  scope :latest, ->{order(date: :desc)}
  # scope :lots_by_number, ->(id){where('sale_id = ?', id).joins(:lots).merge(Lot.order(lotnumber: :asc)).references(:lots)}


  def house_and_date
  	"#{self.house.name} - #{nice_date(self.date)}"
  end
end
