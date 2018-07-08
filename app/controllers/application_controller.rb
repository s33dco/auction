class ApplicationController < ActionController::Base

	before_action	:set_house

	def set_house
		@house = House.first
	end

	  def nice_date(t)
    t.strftime("#{t.day.ordinalize} %B %Y") 
  end

end
