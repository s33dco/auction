class Sale < ApplicationRecord
  belongs_to :house
  has_many :products
end
