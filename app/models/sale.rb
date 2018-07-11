class Sale < ApplicationRecord
  belongs_to :house
  has_many :lots
  has_many :vendors, through: :lots, source: :seller
  has_many :bids, through: :lots
  accepts_nested_attributes_for :lots, allow_destroy: true, reject_if: ->(attrs) { attrs['lotnumber'].blank? || attrs['description'].blank? || attrs['reserve'].blank? || attrs['manufacturer'].blank? }

  scope :descending, ->{order(date: :desc)}
  scope :live, ->{where('active = ?', true)}
  scope :ended, ->{where('complete = ?', true)}
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

  def building?
    complete? && active? == false
  end

  def activate
    update_attributes(active: true, complete: false)
  end

  def deactivate
    update_attributes(active: false, complete: true)
  end

  def generate_report
    lots.by_lot_number.each do |lot|
      if lot.reserve > lot.selling_price
        lot.update_attributes(sold: false, soldat: 0, bfee:0, sfee:0, buyerpaid:true, sellerpaid:true)
      else
        lot.update_attributes(winner:lot.highest_bid.buyer.id, soldat:lot.selling_price, bfee:lot.buyingfee, sfee:lot.sellingfee, sold: true, buyerpaid:false, sellerpaid:false)
      end
    end
  end
end
