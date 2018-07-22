class LotsController < ApplicationController

	before_action :someone_signed_in, only: [:show]
	before_action :check_if_admin, except:[:show]

	def index
		session[:q] = params[:q] if params[:q]
		search
		
		items if search_params

		unless @lots.nil? 
			@gross = @lots.total_gross
			@total_sales = @lots.total_sales
			@buyer_fees	= @lots.total_buyer_fees
			@seller_fees = @lots.total_seller_fees
			@comm = @lots.total_comm
			@pay_out = @lots.pay_out
			@average = @lots.average_profit
			@average_bid = @lots.average_bid
			@how_many = @lots.count
		end

		@saved_for_csv = Lot.auctioned.search(session[:q]).result

		respond_to do |format|
			format.html
			format.csv { send_data @saved_for_csv.to_csv }
		end
		
	end

	def show
		@lot = Lot.find(params[:id])
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

	def items
	  @lots ||= search.result
	  # add .page(params[:page]).per(20) to above to paginate...
	end 

	def search
		@search ||= Lot.auctioned.search(search_params)
	end

	def search_params
		params[:q]
	end

	def lot_params
		params.require(:lot).permit(:dispute, :category_id, :buyer_id, :seller_id, :winner, :soldat, :bfee, :sfee, :sold, :buyerpaid, :sellerpaid)
	end
end
