class BuyersController < ApplicationController

	def index
		@buyers = Buyer.lastname_firstname.page(params[:page]).per(20)
	end

	def show
		@buyer = current_buyer
		@sales = Sale.live
		@unpaid_lots = @buyer.winning_bids.map{|b| b.lot}.select{| l | l.buyerpaid == false && l.sold == true}.sort{|a,b| b.sale.date <=> a.sale.date}
		@unpaid_cash = @unpaid_lots.sum{| l | l.soldat + l.bfee }
		@total_bids_value = @buyer.bids.sum{|b| b.bidvalue}
		@total_bids = @buyer.bids.count
		@total_winning_bids = @buyer.winning_bids.count
		@gross_spend = @buyer.winning_bids.map{|b| b.lot}.sum{| l | l.soldat + l.bfee}
		@since = @buyer.eldest
	end

	def new
		@buyer = Buyer.new
	end

	def create
		@buyer = Buyer.new(buyer_params)
		if @buyer.save
		  redirect_to buyers_path, notice: "#{@buyer.full_name} successfully created!"
		else
		  render :new
		end
	end

	def edit
		@buyer = Buyer.find(params[:id])
	end

	def update
		@buyer = Buyer.find(params[:id])
		if @buyer.update(buyer_params)
		  redirect_to buyers_path, notice: "#{@buyer.full_name} successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@buyer = Buyer.find(params[:id])
		@buyer.destroy
    redirect_to buyers_url, alert: "#{@buyer.full_name} successfully deleted!"
	end

	def bidding
		@buyer = Buyer.find(params[:id])
		@sale = Sale.find(params[:sale])
		@lots = @sale.lots.page(params[:page]).per(20)

	end

	private

	def buyer_params
		params.require(:buyer).permit(:firstname, :lastname, :email, :phone, :commrate, :sale_id, :buyer, :code)
	end
end
