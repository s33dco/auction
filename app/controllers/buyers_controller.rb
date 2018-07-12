class BuyersController < ApplicationController

	def index
		@buyers = Buyer.all
	end

	def show
		@buyer = Buyer.find(params[:id])
		@sales = Sale.live
		@unpaid_lots = @buyer.winning_bids.map{|b| b.lot}.select{| l | l.buyerpaid == false && l.sold == true}
		@unpaid_cash = @unpaid_lots.sum{| l | l.soldat + l.bfee }
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




	def report
		# @buyer = Buyer.first
		# 		if params[:sale_id].in? Sale.house_and_date.map{|s| s.id.to_s}
		# 			@lots = Lot.by_sale(params[:sale_id])
		# 		else
		# 			@lots = Lot.buyerunpaid(@buyer.id)
		# 		end
		# @money = @payments.total
		
		# respond_to do |format|
		# 	format.html
		# 	format.csv { send_data @lot.to_csv }
		# end
	end




	private

	def buyer_params
		params.require(:buyer).permit(:firstname, :lastname, :email, :phone, :commrate)
	end
end
