class LotsController < ApplicationController

	def index
		@lots = Lot.send(lots_scope)
		@gross = @lots.total_gross
		@total_sales = @lots.total_sales
		@buyer_fees	= @lots.total_buyer_fees
		@seller_fees = @lots.total_seller_fees
		@comm = @lots.total_comm
		@pay_out = @lots.pay_out
		@average = @lots.average_profit
		@how_many = @lots.count

		respond_to do |format|
			format.html
			format.csv { send_data @lots.to_csv }
		end
		
	end

	def show
		@lot = Lot.find(params[:id])
		@buyer = Buyer.first
	end

	def edit
		@lot = Lot.find(params[:id])
	end

	def update
	@lot = Lot.find(params[:id])
		if @lot.update(lot_params)
		  redirect_to lots_url notice: "Lot successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@lot = Lot.find(params[:id])
		@lot.destroy
    redirect_to sales_path, alert: "Lot successfully deleted!"
	end

	private

	def lot_params
		params.require(:lot).permit(:category_id, :seller_id, :winner, :soldat, :bfee, :sfee, :sold, :buyerpaid, :sellerpaid)
	end

	def lots_scope
	  if params[:scope].in? %w(auctioned unsold sold)
	    params[:scope]
	  else
	    :sold
	  end
	end


end
