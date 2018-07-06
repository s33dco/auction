class Report < ApplicationRecord
  belongs_to :sale
  belongs_to :lot #is this right ?
  belongs_to :seller
  belongs_to :buyer
end
