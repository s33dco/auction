class House < ApplicationRecord
	has_many :sales
	has_one_attached :banner

	validates :code, :name, presence: true
	validates :email, 			presence: true,
	                  			format: /\A\S+@\S+\z/,
	                  			uniqueness: { case_sensitive: false, message: "Email address already in use"}
	validates :phone,     	numericality:  {message: "just digits no spaces"},
													length: {minimum: 10, maximum: 14}
	validates :address1, :address2, :postcode, presence: true

	scope :home, ->{where("siteinfo = ?", true)}
	scope :alpha, ->{order(name: :asc)}
end
