class BidsController < ApplicationController

	def index
		@sales = Sale.send(sales_scope)
	end

	def show
		@sale = Sale.find(params[:id])
		@lots = @sale.lots.by_lot_number
	end

	def create
		@lot = Lot.find(params[:bid][:lot_id])
		@bid = @lot.bids.new(bid_params)
		@bid.buyer_id = 1 #this will be current buyer from devise
		@bid.sale = @lot.sale
		if @bid.save
			redirect_to sale_path(@lot.sale), notice: "Bid accepted #{@bid.buyer.full_name}!"
		else
			flash.now[:alert] = 'bid not accepted'
			redirect_to lot_path(@lot)
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
