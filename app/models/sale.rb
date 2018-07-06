class Sale < ApplicationRecord
  belongs_to :house
  has_many :lots
  has_many :reports
  has_many :vendors, through: :lots, source: :seller
  has_many :bids, through: :lots
  accepts_nested_attributes_for :lots

  scope :descending, ->{order(date: :desc)}
  scope :active, ->{where('active = ?', true)}
  scope :complete, ->{where('complete = ?', true)}
  scope :just_done, ->{complete.order(date: :desc).first}

  
  def live_lots_asc
   lots.sort{| b,a| b.lotnumber <=> a.lotnumber}
  end

  def house_and_date
  	"#{house.name} #{nice_date(date)}"
  end

  def active?
  	active == true
  end

  def complete?
    complete == true
  end

  def frozen?
    complete? || active? == true
  end

end
