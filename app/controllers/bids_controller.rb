class BidsController < ApplicationController

	def create
		fail
		@lot = Lot.find(params[:bid][:lot_id])
		@bid = @lot.bids.new(bid_params)
		@bid.buyer_id = 1 #this will be current buyer from devise
		if @bid.save
			redirect_to sale_path(@lot.sale), notice: "Bid accepted!"
		else
			render :back, alert: "not accepted!"
		end
	end

	private

	def bid_params
		params.require(:bid).permit(:bidvalue, :lot_id)
	end

end
