class ApplicationController < ActionController::Base
	
	rescue_from ActiveRecord::RecordNotFound, :with => :render_404

	before_action	:set_house
	# before_action :set_active_sale

	def render_404
	  redirect_to root_url, alert: "Can't find that for you!"
	end


	def set_house
		@default = House.home.first
	end

	# def set_active_sale
	# 	@sale = Sale.live
	# end

	def nice_date(t)
	  t.strftime("#{t.day.ordinalize} %B %Y") 
	end


	# access control methods

	private

	def auctioneer_or_buyer_logged_in
			unless auctioneer_signed_in? || buyer_signed_in? 
				redirect_to root_url, alert: "You'll need to sign in first."
			end
		end

	def check_if_buyer_or_admin
		unless auctioneer_signed_in? || (buyer_signed_in? && current_buyer == Buyer.find(params[:id])) 
			redirect_to root_url, alert: "You'll need to sign in first."
		end
	end

	def check_bid_buyer_or_admin
		unless auctioneer_signed_in? || buyer_signed_in?
			redirect_to root_url, alert: "You'll need to sign in first."
		end
	end

	def check_if_admin
		unless auctioneer_signed_in?
			redirect_to root_url, alert: "You'll need to sign in first."
		end
	end

	def check_if_seller_or_admin
		unless auctioneer_signed_in? || (seller_signed_in? && current_seller == Seller.find(params[:id])) 
			redirect_to root_url, alert: "You'll need to sign in first."
		end
	end

	def check_permitted_sale
		unless params[:sale].to_i.in? current_buyer.houses.each.map{|h| h.sales}.flatten.select{|s| s.active == true}.map{|s| s.id}
			redirect_to buyer_path(current_buyer), alert: "Bids not accepted for this auction."
		end
	end

end






