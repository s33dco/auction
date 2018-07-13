class SellersController < ApplicationController
	def index
		@sellers = Seller.all
	end

	def show
		@seller = Seller.find(params[:id])
		@active_lots = @seller.lots.select{| l | l.sold.nil? }
		@sold_lots = @seller.lots.select{| l | l.sold == true && l.sellerpaid == false}
		@unsold_lots = @seller.lots.select{| l | l.sold == false && l.sellerpaid == false }
		@cash_due_to_seller = @sold_lots.sum{| l | (l.seller_due)}
		@cash_made_by_seller = @seller.lots.select{| l | l.sold == true}.sum{| l | (l.seller_due)}
	end

	def new
		@seller = Seller.new
	end

	def create
		@seller = Seller.new(seller_params)
		if @seller.save
		  redirect_to @seller, notice: "#{@seller.full_name} created!"
		else
		  render :new
		end
	end

	def edit
		@seller = Seller.find(params[:id])
	end

	def update
		@seller = Seller.find(params[:id])
		if @seller.update(seller_params)
		  redirect_to @seller, notice: "#{@seller.full_name} updated!"
		else
		  render :edit
		end
	end

	def destroy
		@seller = Seller.find(params[:id])
		@seller.destroy
    redirect_to sellers_url, alert: "#{@seller.full_name} deleted!"
	end

	private

	def seller_params
		params.require(:seller).permit(:firstname, :lastname, :email, :phone, :commrate)
	end
end
