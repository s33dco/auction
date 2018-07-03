class ApplicationController < ActionController::Base

	before_action	:set_house

	def set_house
		@house = House.first
	end

end
