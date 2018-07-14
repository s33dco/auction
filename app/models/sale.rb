class Sale < ApplicationRecord
  belongs_to :house
  has_many :lots
  has_many :vendors, through: :lots, source: :seller
  has_many :bids
  has_many :bidders, through: :bids, source: :buyer
  accepts_nested_attributes_for :lots, allow_destroy: true, reject_if: ->(attrs) { attrs['lotnumber'].blank? || attrs['description'].blank? || attrs['reserve'].blank? || attrs['manufacturer'].blank? }

  validates :date, presence: true
  validates_numericality_of :notch, :minfee, presence: true, greater_than_or_equal_to: 0

  scope :descending, ->{order(date: :desc)}
  scope :live, ->{where('active = ?', true)}
  scope :ended, ->{where('complete = ?', true)}
  scope :previous, ->{ended.order(date: :desc)}
  scope :just_ended, ->{ended.order(date: :desc).first}

 
  def ordered_bidders
    bidders.uniq.sort{|a,b| a.lastname <=> b.lastname}
    
  end

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
    lots.each do |lot|
      if lot.reserve > lot.highest_bid_value
        lot.update_attributes(sold: false, soldat: 0, bfee:0, sfee:0) # not setting buyer/sellerpaid to true as these attributes decide lot populating on show page of relevant nodel
      else
        lot.update_attributes(soldat:lot.selling_price, bfee:lot.buyingfee, sfee:lot.sellingfee, sold: true, buyerpaid:false, sellerpaid:false)
        lot.highest_bid.first.update(won: true)
      end
    end
  end
end
