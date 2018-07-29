class Auctioneer < ApplicationRecord
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

	 def password_required?
	   false
	 end

	 def email_required?
	   true
	 end

end
