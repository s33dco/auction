class HousesController < ApplicationController

	before_action :check_if_admin

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
		  redirect_to houses_path, notice: "#{@house.name} successfully created!"
		else
		  render :new
		end
	end

	def edit
		@house = House.find(params[:id])
	end

	def update
		@house = House.find(params[:id])
		if @house.update(house_params)
		  redirect_to houses_path, notice: "#{@house.name} successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@house = House.find(params[:id])
		@house.destroy
    redirect_to houses_path, alert: "#{@house.name} successfully deleted!"
	end

	private

	def house_params
		params.require(:house).permit(:code, :name, :siteinfo, :address1, :address2, :address3, :postcode, :phone, :email, :id)
	end
end
