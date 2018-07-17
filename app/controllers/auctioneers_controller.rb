class AuctioneersController < ApplicationController
	def index
		@auctioneers = Auctioneer.all
	end

	def show
		@auctioneer = Auctioneer.find(params[:id])
	end

	def edit
		@auctioneer = Auctioneer.find(params[:id])
	end

	def update
		@auctioneer = Auctioneer.find(params[:id])
		if @auctioneer.update(auctioneer_params)
		  redirect_to auctioneers_url, notice: "#{@auctioneer.name} successfully updated!"
		else
		  render :edit
		end
	end

	def new
		@auctioneer = Auctioneer.new
	end

	def create
		@auctioneer = Auctioneer.new(auctioneer_params)
		if @auctioneer.save
		  redirect_to auctioneers_path, notice: "#{@auctioneer.name} successfully created!"
		else
		  render :new
		end
		
	end

	def destroy
		@auctioneer = Auctioneer.find(params[:id])
		@auctioneer.destroy
		redirect_to auctioneers_url, alert: "#{@auctioneer.name} successfully deleted!"
	end


private
	def auctioneer_params
		params.require(:auctioneer).permit(:name, :email, :phone, :password)
	end
end
