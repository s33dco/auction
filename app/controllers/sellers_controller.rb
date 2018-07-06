class SellersController < ApplicationController
		def index
			@sellers = Seller.all
		end

		def show
			@seller = Seller.find(params[:id])
		end

		def new
			@seller = Seller.new
		end

		def create
			@seller = Seller.new(seller_params)
			if @seller.save
			  redirect_to @seller, notice: "Seller successfully created!"
			else
			  render :new
			end
		end

		def update
			@seller = Seller.find(params[:id])
			if @seller.update(seller_params)
			  redirect_to @seller, notice: "Seller successfully updated!"
			else
			  render :edit
			end
		end

		def destroy
			@seller = Seller.find(params[:id])
			@seller.destroy
	    redirect_to sellers_url, alert: "Seller successfully deleted!"
		end

		private

		def seller_params
			params.require(:seller).permit(:firstname, :lastname, :email, :phone, :commrate)
		end
end
