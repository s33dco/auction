class HousesController < ApplicationController

	def index
		@houses = House.alpha
	end

	def show
		@house = House.find(params[:id])
	end

	def new
		@house = House.new
	end

	def create
		@house = House.new(house_params)
		if @house.save
		  redirect_to @house, notice: "House successfully created!"
		else
		  render :new
		end
	end

	def update
		@house = House.find(params[:id])
		if @house.update(house_params)
		  redirect_to @house, notice: "House successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@house = House.find(params[:id])
		@house.destroy
    redirect_to houses_url, alert: "House successfully deleted!"
	end

	private

	def house_params
		params.require(:house).permit(:name, :address1, :address2, :address3, :postcode, :phone, :email)
	end
end
