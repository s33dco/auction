class BidsController < ApplicationController

	before_action :check_bid_buyer_or_admin, only:[:create]
	before_action :check_if_admin, except:[:create]

	def index
		@sales = Sale.send(sales_scope).page(params[:page]).per(10)
	end

	def show
		@sale = Sale.find(params[:id])
		@lots = @sale.lots.by_lot_number.page(params[:page]).per(10)
	end


	def create
		@lot = Lot.find(params[:bid][:lot_id])
		@buyer = current_buyer
		if @lot.sale.active && @lot.sale.house.in?(@buyer.houses)
			@bid = @lot.bids.new(bid_params)
			@bid.buyer_id = current_buyer.id 
			@bid.sale = @lot.sale
			if @bid.save
				redirect_to buyer_bidding_path(current_buyer, @bid.sale.id), notice: "Bid accepted #{current_buyer.full_name}!"
			else
				flash.now[:alert] = 'bid not accepted - too low'
				render template: 'lots/show'
			end
		else
			redirect_to buyer_url(current_buyer), alert: "Bids are not accepted for this lot"
		end
	end

	private

	def bid_params
		params.require(:bid).permit(:bidvalue, :lot_id)
	end

	def sales_scope
	  if params[:scope].in? %w(ended live)
	    params[:scope]
	  else
	    :live
	  end
	end

end
