class ApplicationController < ActionController::Base
	before_action	:set_house
	before_action :set_active_sale

	def set_house
		@house = House.home.first
	end

	def set_active_sale
		@sale = Sale.active.first
	end


end
