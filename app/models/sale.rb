class Sale < ApplicationRecord
  belongs_to :house
  has_many :lots
  has_many :reports
  has_many :vendors, through: :lots, source: :seller
  has_many :bids, through: :lots
  accepts_nested_attributes_for :lots, allow_destroy: true, reject_if: ->(attrs) { attrs['lotnumber'].blank? || attrs['description'].blank? || attrs['reserve'].blank? || attrs['manufacturer'].blank? }

  scope :descending, ->{order(date: :desc)}
  scope :active, ->{where('active = ?', true)}
  scope :complete, ->{where('complete = ?', true)}
  scope :just_done, ->{complete.order(date: :desc).first}
  scope :building, ->{ where('complete & active = ?', false)}

  
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

  def activate
    update_attributes(active: true, complete: false)
  end

  def deactivate
    update_attributes(active: false, complete: true)
  end

  def generate_report
    # for each lot in sale write corresponding record in Report detailing selling price and commisions
    self.lots.by_lot_number.each do |lot|
      report              = Report.new
      report.sale_id      = lot.sale.id
      report.lot_id       = lot.id
      report.seller_id    = lot.seller.id
      report.buyer_id     = lot.bids.highest_bid.buyer.id
      report.sold_at      = lot.selling_price
      # todo deal with minimal fee charging
      report.buyer_fee    = (lot.selling_price / 100) * lot.bids.highest_bid.buyer.commrate
      report.seller_fee   = (lot.selling_price / 100) * lot.seller.commrate
      report.category_id  = lot.category_id
      report.save
    end
  end
end
