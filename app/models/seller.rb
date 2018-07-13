class Seller < ApplicationRecord
	has_many :lots

	validates :firstname, presence: true,
											  format: { with: /\A[a-z\s]+\Z/i, message: "only letters" },
                        length: { minimum: 1}

	validates :lastname, 	presence: true,
											  format: { with: /\A[a-z\s]+\Z/i, message: "only letters" },
												length: { minimum: 2 }

  validates :email, 		presence: true,
                    		format: /\A\S+@\S+\z/,
                    		uniqueness: { case_sensitive: false , 
                    									message: "Email address already in use"}

  validates :phone,     numericality:  {message: "just digits no spaces"},
  											length: {minimum: 10, maximum: 14}

  validates :code, 			presence: true

	validates_numericality_of :commrate, presence: true,
														greater_than_or_equal_to: 0

	scope :by_code, ->{order(code: :asc)}

	def full_name
		"#{firstname} #{lastname}"
	end

	def code_and_name
		"#{code} (#{firstname} #{lastname})"
	end
end
