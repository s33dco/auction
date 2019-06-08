class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def nice_date(t)
    t.strftime("#{t.day.ordinalize} %B %Y")
  end

  def first_and_last_name
  	"#{firstname} #{lastname}"
  end

  def short_date(t)
  	t.strftime("%v")
  end

end
