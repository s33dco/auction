class BuyersController < ApplicationController
		def index
			@buyers = Buyer.all
		end

		def show
			@buyer = Buyer.find(params[:id])
			@lots = Sale.active.first.lots.by_lot_number unless Sale.active.blank? 
			# can return nil value so catch in view and display check back message
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
	    redirect_to buyerss_url, alert: "Buyer successfully deleted!"
		end

		private

		def buyer_params
			params.require(:buyer).permit(:firstname, :lastname, :email, :phone, :commrate)
		end
	end
end
