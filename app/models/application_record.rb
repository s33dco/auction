class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def nice_date(t)
    t.strftime("#{t.day.ordinalize} %B %Y") 
  end

end
