class ApplicationController < ActionController::Base
	before_action	:set_house
	before_action :set_active_sale

	def set_house
		@house = House.home.first
	end

	def set_active_sale
		@sale = Sale.active.first
	end

	 def nice_date(t)
    t.strftime("#{t.day.ordinalize} %B %Y") 
  end

end
