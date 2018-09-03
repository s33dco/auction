class Auctioneer < ApplicationRecord
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, 		presence: true,
                    		format: /\A\S+@\S+\z/,
                    		uniqueness: { case_sensitive: false , 
                    									message: "Email address already in use"}

  validates :name, presence: true,
											  format: { with: /\A[a-z\s]+\Z/i, message: "only letters" },
                        length: { minimum: 1}


# below for devise, no password needed just email

	def password_required?
	 false
	end

	def email_required?
	 true
	end

end
