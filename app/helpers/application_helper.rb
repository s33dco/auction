module ApplicationHelper

# for meta page titles 

  def title(title)
  	content_for(:title, title)
  end

	def page_title
  	if content_for?(:title)
  		"#{content_for(:title)} | #{ENV['COOP_SHORT_NAME']}"
  	else
  		"#{ENV['COOP_NAME']}"
  	end
  end

 # for meta descriptions

  def description(description)
  	content_for(:description, description)
  end

	def page_description
  	if content_for?(:description)
  		"#{content_for(:description)}"
  	else
  		"#{ENV['COOP_DESCRIPTION']}"
  	end
  end

  # nice date
  def nice_date(t)
    t.strftime("#{t.day.ordinalize} %B %Y") 
  end

end
