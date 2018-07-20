class BuyersController < ApplicationController
	before_action :check_if_buyer_or_admin, only:[:show, :bidding]
	before_action :check_if_admin, except:[:show, :bidding]

	# check current_buyer = Buyer.find(params[:id]) on show & bidding
	# all other action restrict to auctioneer_signed_in?

	def index
		@buyers = Buyer.lastname_firstname.page(params[:page]).per(20)
	end

	def show
		@buyer = Buyer.find(params[:id])
		@sales = Sale.live
		@winning_lots =  @buyer.lots
		@unpaid_lots = @winning_lots.select{| l | l.buyerpaid == false && l.sold == true && l.dispute == false}.sort{|a,b| b.sale.date <=> a.sale.date}
		@disputed_lots = @winning_lots.select{| l | l.dispute == true}.sort{|a,b| b.sale.date <=> a.sale.date}
		@paid_lots = @winning_lots.select{| l | l.buyerpaid == true && l.sold == true && l.dispute == false}.sort{|a,b| b.sale.date <=> a.sale.date}
		@gross_spend = @paid_lots.sum{| l | l.soldat + l.bfee }
		@unpaid_cash = @unpaid_lots.sum{| l | l.soldat + l.bfee }
		@disputed_cash = @disputed_lots.sum{| l | l.soldat + l.bfee }
		@total_bids = @buyer.bids.count
		@total_winning_bids = @winning_lots.count
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
