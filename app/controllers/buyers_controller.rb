class BuyersController < ApplicationController
		def index
			@buyers = Buyer.all
		end

		def show
			@buyer = Buyer.find(params[:id])
			@bidding_card = Sale.active.first.lots.by_lot_number unless Sale.active.blank? 
			# can return nil value so catch in view and display check back message
			@previous_card = Sale.just_done.first.lots.by_lot_number
		end

		def new
			@buyer = Buyer.new
		end

		def create
			@buyer = Buyer.new(buyer_params)
			if @buyer.save
			  redirect_to @buyer, notice: "Buyer successfully created!"
			else
			  render :new
			end
		end

		def update
			@buyer = Buyer.find(params[:id])
			if @buyer.update(buyer_params)
			  redirect_to @buyer, notice: "Buyer successfully updated!"
			else
			  render :edit
			end
		end

		def destroy
			@buyer = Buyer.find(params[:id])
			@buyer.destroy
	    redirect_to buyers_url, alert: "Buyer successfully deleted!"
		end

		private

		def buyer_params
			params.require(:buyer).permit(:firstname, :lastname, :email, :phone, :commrate)
		end
end
