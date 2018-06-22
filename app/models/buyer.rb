class Buyer < ApplicationRecord
	has_many :bids
	has_many :bidon, through: :bids, source: :lot
end
