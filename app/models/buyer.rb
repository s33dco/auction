class Buyer < ApplicationRecord

  devise :database_authenticatable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :bids
	has_many :bidon, through: :bids, source: :lot
	has_many :lots
	has_and_belongs_to_many :houses



	validates :firstname, presence: true,
											  format: { with: /\A[a-z\s]+\Z/i, message: "only letters" },
                        length: { minimum: 1}

	validates :lastname, 	presence: true,
											  format: { with: /\A[a-z\s]+\Z/i, message: "only letters" },
												length: { minimum: 1 }

  validates :email, 		presence: true,
                    		format: /\A\S+@\S+\z/,
                    		uniqueness: { case_sensitive: false , 
                    									message: "Email address already in use"}

  # validates :phone,     numericality:  {message: "just digits no spaces"},
  # 											length: {minimum: 10, maximum: 14}

  # validates :code, 			presence: true

	validates_numericality_of :commrate, presence: true,
														greater_than_or_equal_to: 0
														
	scope :by_code, ->{order(buyercode: :asc)}
	scope :lastname_firstname, ->{order(lastname: :asc).order(firstname: :asc)}

	def password_required?
	  false
	end

	def email_required?
	  false
	end

	def eldest
		bids.order(created_at: :asc).first.sale.date unless bids.empty?
	end


	def bid_for(lot)
		bids.where('lot_id = ?', lot)
	end

	def full_name
		"#{firstname} #{lastname}"
	end

	def code_and_name
		"#{code} (#{firstname} #{lastname})"
	end

	def winning_bids
		bids.where(won: true)
	end

	def winning_by_date
		winning_bids.map{|b| b.sale}.sort{|a , b| b.date <=> a.date}.map{|s| s.bids}
	end

	def winning_bids_in(sale)
		winning_bids.joins(:sale).where(sale_id: sale)
	end

	def bids_to_pay
		winning_bids.each do |bid |
			total_due = 0
			unless bid.lot.buyerpaid
				total_due = (bid.lot.bfee + bid.lot.soldat) + total_due
			end
		end
	end
end
