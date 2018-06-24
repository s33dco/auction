class Sale < ApplicationRecord
  belongs_to :house
  has_many :lots
  has_many :vendors, through: :lots, source: :seller
  has_many :bids, through: :lots

  scope :latest, ->{order(date: :desc)}
  scope :active, ->{where('active = ?', true)}

  def house_and_date
  	"#{house.name} #{nice_date(date)}"
  end

  def active?
  	active == true
  end

end
