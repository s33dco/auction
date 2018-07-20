class SellersController < ApplicationController

	before_action :check_if_seller_or_admin, only:[:show]
	before_action :check_if_admin, except:[:show]


	def index
		@sellers = Seller.lastname_firstname.page(params[:page]).per(20)
	end

	def show
		@seller = Seller.find(params[:id])
		@active_lots = @seller.lots.select{| l | l.sold.nil? }.sort{|a,b| b.lotnumber<=> a.lotnumber}.sort{|a,b| b.sale.date <=> a.sale.date}
		@sold_lots = @seller.lots.select{| l | l.sold == true && l.sellerpaid == false && l.dispute == false }.sort{|a,b| b.sale.date <=> a.sale.date}
		@disputed_lots = @seller.lots.select{| l | l.dispute == true }.sort{|a,b| b.sale.date <=> a.sale.date}
		@unsold_lots = @seller.lots.select{| l | l.sold == false && l.sellerpaid == false }.sort{|a,b| b.sale.date <=> a.sale.date}
		@cash_made_by_seller = @seller.lots.select{| l | l.sold == true && l.sellerpaid == true && l.dispute == false }.sum{| l | (l.seller_due)} # lots paid
		@cash_due_to_seller = @sold_lots.sum{| l | (l.seller_due)}
		@total_lots_sold_by_seller = @seller.lots.select{|l| l.sold == true}.count
		@since = @seller.eldest
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
		params.require(:seller).permit(:firstname, :lastname, :email, :phone, :commrate, :password, :code)
	end
end
