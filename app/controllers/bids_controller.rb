class BidsController < ApplicationController

	def index
		@sales = Sale.active
	end

	def show
		@sale = Sale.find(params[:id])
		@lots = @sale.lots.by_lot_number
	end

	def create
		@lot = Lot.find(params[:bid][:lot_id])
		@bid = @lot.bids.new(bid_params)
		@bid.buyer_id = 1 #this will be current buyer from devise
		if @bid.save
			redirect_to sale_path(@lot.sale), notice: "Bid accepted #{@bid.buyer.full_name}!"
		else
			render :back, alert: "not accepted!"
		end
	end

	private

	def bid_params
		params.require(:bid).permit(:bidvalue, :lot_id)
	end

end
