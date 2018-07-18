class BidsController < ApplicationController

	def index
		@sales = Sale.send(sales_scope).page(params[:page]).per(20)
	end

	def show
		@sale = Sale.find(params[:id])
		@lots = @sale.lots.by_lot_number.page(params[:page]).per(10)
	end

	def create
		#to do current buyer !
		# todo stop bids being created if !@lot.sale.active
		@lot = Lot.find(params[:bid][:lot_id])
		@bid = @lot.bids.new(bid_params)
		@bid.buyer_id = current_buyer.id
		@buyer =  current_buyer
		@bid.sale = @lot.sale
		if @bid.save
			redirect_to buyer_bidding_path(@buyer, @bid.sale), notice: "Bid accepted #{@buyer.full_name}!"
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
